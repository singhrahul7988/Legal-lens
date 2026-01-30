import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:legal_lens_client/legal_lens_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../core/services/user_image_service.dart';
import '../main.dart';
import '../core/theme/app_theme.dart';
import '../core/models/document_model.dart';
import '../core/services/document_repository.dart';
import '../core/utils/intent_classifier.dart';
import '../core/services/session_manager.dart';
import '../core/utils/document_processor.dart';
import 'dart:typed_data';

enum ConversationPhase {
  general,
  specific,
}

class AskAIScreen extends StatefulWidget {
  const AskAIScreen({super.key, this.onBack, this.initialDocId});

  final VoidCallback? onBack;
  final String? initialDocId;

  @override
  State<AskAIScreen> createState() => _AskAIScreenState();
}

class _AskAIScreenState extends State<AskAIScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  String? _attachedFileName;
  Uint8List? _attachedFileBytes;
  bool _isTyping = false;
  String? _contextId;
  
  // Current document context
  DocumentModel? _currentDoc;
  ConversationPhase _phase = ConversationPhase.general;

  @override
  void initState() {
    super.initState();
    _loadChatHistory();
  }

  void _loadChatHistory() {
    if (widget.initialDocId != null) {
      _currentDoc = DocumentRepository().getDocument(widget.initialDocId!);
      if (_currentDoc != null) {
        _phase = ConversationPhase.specific;
      }
    }

    // Default Greeting
    if (_currentDoc != null) {
        String greeting = "Hello! I'm here to discuss **${_currentDoc!.name}**. What would you like to know about this document?";
        List<String> suggestions = ["Summarize findings", "What are the red flags?", "Is this legally binding?"];
        
        _messages.add(ChatMessage(
            text: greeting,
            isUser: false,
            timestamp: _getCurrentTime(),
            suggestions: suggestions,
        ));
    } else {
        String greeting = "Hello! I'm your Legal Lens AI assistant. I have context on your previously analyzed files. You can ask me questions about them, or upload a new document to discuss.";
        List<String> suggestions = ["List all analyzed documents", "Summarize Document", "Check for Risks"];
        
        _messages.add(ChatMessage(
            text: greeting,
            isUser: false,
            timestamp: _getCurrentTime(),
            suggestions: suggestions,
        ));
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return "$hour:${time.minute.toString().padLeft(2, '0')} $period";
  }

  String _getCurrentTime() {
    return _formatTime(DateTime.now());
  }

  Future<void> _handleAttachment() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
        withData: true,
      );

      if (result != null) {
        setState(() {
          _attachedFileName = result.files.single.name;
          _attachedFileBytes = result.files.single.bytes;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking file: $e')),
        );
      }
    }
  }

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty && _attachedFileName == null) return;

    final userText = _controller.text.trim();
    final attachedFileName = _attachedFileName;
    final attachedFileBytes = _attachedFileBytes;
    final timestamp = _getCurrentTime();

    setState(() {
      String messageText = userText;
      if (attachedFileName != null) {
        messageText = "[Attached: $attachedFileName]\n\n$userText";
      }
      
      _messages.add(ChatMessage(
        text: messageText.trim(),
        isUser: true,
        timestamp: timestamp,
      ));
      _controller.clear();
      _attachedFileName = null;
      _attachedFileBytes = null;
      _isTyping = true;
    });
    _scrollToBottom();

    // Prepare content if attached
    String? newDocContent;
    if (attachedFileName != null) {
         try {
             newDocContent = await DocumentProcessor.extractContent(
                 name: attachedFileName,
                 bytes: attachedFileBytes,
             );
         } catch (e) {
             debugPrint("Error extracting content: $e");
         }
    }

    // Client-side Intent Switch
    final intent = IntentClassifier.classify(userText, DocumentRepository().documents.isNotEmpty);
    
    if (intent == IntentType.general) {
        setState(() { 
            _currentDoc = null; 
            _phase = ConversationPhase.general; 
        });
    } else if (intent == IntentType.specific && _currentDoc == null) {
        final docs = DocumentRepository().documents;
        if (docs.isNotEmpty) {
             setState(() { 
                 _currentDoc = docs.last; 
                 _phase = ConversationPhase.specific; 
             });
        }
    }

    try {
        final request = AiChatRequest(
            userInput: userText,
            contextId: _contextId,
            sessionId: SessionManager().sessionId,
            docId: _currentDoc?.serverId,
            newDocContent: newDocContent,
            newDocName: attachedFileName,
        );

        final response = await client.ai.chat(request);

        // If we uploaded a document, refresh the repository to show it in the list
        if (newDocContent != null) {
          DocumentRepository().fetchDocuments();
        }

        if (mounted) {
            setState(() {
                _isTyping = false;
                _contextId = response.contextId;
                _messages.add(ChatMessage(
                    text: response.aiResponse,
                    isUser: false,
                    timestamp: _getCurrentTime(),
                    suggestions: response.suggestedFollowups,
                ));
            });
            _scrollToBottom();
        }
    } catch (e) {
        if (mounted) {
            setState(() {
                _isTyping = false;
                _messages.add(ChatMessage(
                    text: "I'm having trouble connecting to the server. Please try again.",
                    isUser: false,
                    timestamp: _getCurrentTime(),
                ));
            });
            debugPrint("Error: $e");
        }
    }
  }

  // _generateAIResponse removed


  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: _messages.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildDateSeparator();
                }
                final message = _messages[index - 1];
                return _buildMessageBubble(message);
              },
            ),
          ),
          if (_isTyping)
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 8),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16, 
                    height: 16, 
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.textGrey),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "AI is thinking...",
                    style: TextStyle(color: AppColors.textGrey.withValues(alpha: 0.8), fontSize: 12),
                  ),
                ],
              ),
            ),
          _buildInputArea(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: AppColors.textDark, size: 20),
        onPressed: () {
          if (widget.onBack != null) {
            widget.onBack!();
          } else {
            Navigator.of(context).maybePop();
          }
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ask AI Butler',
            style: TextStyle(
              color: AppColors.textDark,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _phase == ConversationPhase.general 
                ? 'GENERAL LEGAL ASSISTANT' 
                : 'ANALYZING: ${_currentDoc?.name ?? "DOCUMENT"}',
            style: TextStyle(
              color: AppColors.textGrey.withValues(alpha: 0.8),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ValueListenableBuilder<String?>(
            valueListenable: UserImageService().profileImageNotifier,
            builder: (context, imageUrl, _) {
              return CircleAvatar(
                radius: 18,
                backgroundImage: imageUrl != null 
                    ? CachedNetworkImageProvider(imageUrl)
                    : null,
                backgroundColor: Colors.grey.shade200,
                child: imageUrl == null 
                    ? const Icon(Icons.person, color: Colors.grey, size: 20)
                    : null,
              );
            },
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: Colors.grey.shade100,
          height: 1,
        ),
      ),
    );
  }

  Widget _buildDateSeparator() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 24, top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'Today',
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: message.isUser ? AppColors.primaryBlue : AppColors.background,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: message.isUser ? const Radius.circular(20) : const Radius.circular(4),
                      bottomRight: message.isUser ? const Radius.circular(4) : const Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: message.isUser ? Colors.white : AppColors.textDark,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  message.timestamp,
                  style: TextStyle(
                    color: AppColors.textGrey.withValues(alpha: 0.6),
                    fontSize: 11,
                  ),
                ),
                if (message.suggestions != null && message.suggestions!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: message.suggestions!.map((suggestion) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 8),
                        child: InkWell(
                          onTap: () {
                            _controller.text = suggestion;
                            _sendMessage();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              suggestion,
                              style: const TextStyle(
                                color: AppColors.primaryBlue,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 12),
            ValueListenableBuilder<String?>(
              valueListenable: UserImageService().profileImageNotifier,
              builder: (context, imageUrl, _) {
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                    image: imageUrl != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(imageUrl),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imageUrl == null
                      ? const Icon(Icons.person, color: Colors.grey, size: 20)
                      : null,
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          if (_attachedFileName != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.primaryBlue),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.attach_file, size: 16, color: AppColors.primaryBlue),
                        const SizedBox(width: 4),
                        Text(
                          _attachedFileName!,
                          style: const TextStyle(
                            color: AppColors.primaryBlue,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _attachedFileName = null;
                            });
                          },
                          child: const Icon(Icons.close, size: 16, color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.attach_file, 
                          color: _attachedFileName != null ? AppColors.primaryBlue : AppColors.textGrey.withValues(alpha: 0.6)
                        ),
                        onPressed: _handleAttachment,
                        tooltip: 'Attach file',
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          onSubmitted: (_) => _sendMessage(),
                          decoration: InputDecoration(
                            hintText: _attachedFileName != null ? 'Ask about this file...' : 'Ask about your documents...',
                            hintStyle: TextStyle(
                              color: AppColors.textGrey.withValues(alpha: 0.6),
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: Colors.white, size: 22),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final String timestamp;
  final List<String>? suggestions;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.suggestions,
  });
}
