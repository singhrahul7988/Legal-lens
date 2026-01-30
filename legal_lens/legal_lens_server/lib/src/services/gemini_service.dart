import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static GeminiService? mockInstance;
  final String apiKey;
  late final GenerativeModel _model;

  GeminiService(this.apiKey) {
    _model = GenerativeModel(
      model: 'gemini-flash-latest',
      apiKey: apiKey,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'),
    );
  }

  Future<Map<String, dynamic>> chatSession({
    required String userInput,
    required List<Map<String, String>> history,
    String? docContent,
    String? docName,
    String? systemContext,
  }) async {
    if (mockInstance != null) {
      return mockInstance!.chatSession(
        userInput: userInput,
        history: history,
        docContent: docContent,
        docName: docName,
        systemContext: systemContext,
      );
    }

    final historyText = history.map((h) => "${h['role']}: ${h['text']}").join("\n");
    
    String contextPrompt = "";
    if (docContent != null && docName != null) {
      contextPrompt = '''
      You are acting as a Document-aware expert.
      Focus on the following document: "$docName".
      
      Document Content:
      $docContent
      
      Instructions:
      1. Preface answers with "Based on the document you provided..." if relying on the document.
      2. Cite page/section references where possible.
      3. Offer definitions for technical terms if asked.
      ''';
    } else {
      contextPrompt = '''
      You are acting as a General-purpose legal assistant.
      
      Instructions:
      1. Be concise but friendly.
      2. If the user asks about a document but none is provided, gently remind them to upload one.
      3. Do NOT make up laws; provide general legal information.
      ''';
    }

    if (systemContext != null) {
      contextPrompt += "\n\nAdditional Context (Session Documents):\n$systemContext\n";
    }

    final prompt = '''
    $contextPrompt

    Conversation History:
    $historyText

    Current User Input:
    $userInput

    Task:
    Provide a response to the user's input based on the context.
    Also provide up to 3 short follow-up questions.
    
    Guardrails:
    - Reject harmful or off-topic requests with: "I can't help with that. Is there anything else I can assist you with?"
    - Ensure accuracy.
    
    Output Format (JSON):
    {
      "response": "Markdown formatted response string",
      "suggestions": ["Suggestion 1", "Suggestion 2", "Suggestion 3"]
    }
    ''';

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);
      
      if (response.text == null) {
        throw Exception('Empty response from Gemini');
      }

      final json = jsonDecode(response.text!);
      return {
        "response": json['response'] ?? "I'm sorry, I couldn't generate a response.",
        "suggestions": List<String>.from(json['suggestions'] ?? []),
      };
    } catch (e) {
      return {
        "response": "I encountered an error processing your request. Please try again.",
        "suggestions": ["Retry"],
      };
    }
  }

  Future<String> analyzeDocument(String textContent, String docType) async {
    if (mockInstance != null) {
      return mockInstance!.analyzeDocument(textContent, docType);
    }

    final isImage = textContent.startsWith('data:image');
    
    final promptText = '''
    Analyze the following $docType document.
    Return the result strictly in JSON format with the following structure:
    {
      "title": "A short title for the document",
      "score": 0-100 (integer, where 100 is safest, 0 is riskiest),
      "riskLabel": "Safe", "Moderate Risk", or "High Risk",
      "riskDescription": "A brief explanation of the risk level.",
      "riskColor": "Hex color string (e.g., #FF0000 for high risk, #00FF00 for safe)",
      "summaryPoints": ["Key point 1", "Key point 2", "Key point 3"],
      "redFlags": [
        {
          "title": "Short title of the risk",
          "description": "Detailed explanation",
          "severity": "High", "Medium", or "Low"
        }
      ],
      "totalAmount": null or number (if applicable, e.g. for bills),
      "insuranceCovered": null or number (if applicable),
      "outOfPocket": null or number (if applicable)
    }

    ${isImage ? "Analyze the image provided." : "Document Content:\n$textContent"}
    ''';

    try {
      List<Part> parts = [TextPart(promptText)];

      if (isImage) {
        // Extract Base64 Data
        // Format: data:image/jpeg;base64,....
        final commaIndex = textContent.indexOf(',');
        if (commaIndex != -1) {
          final header = textContent.substring(0, commaIndex);
          final base64Str = textContent.substring(commaIndex + 1);
          final mimeType = header.substring(5, header.indexOf(';'));
          
          parts.add(DataPart(mimeType, base64Decode(base64Str)));
        }
      }

      final content = [Content.multi(parts)];
      final response = await _model.generateContent(content);
      
      if (response.text == null) {
        throw Exception('Empty response from Gemini');
      }

      // Verify it's valid JSON
      final text = response.text!;
      final startIndex = text.indexOf('{');
      final endIndex = text.lastIndexOf('}');
      
      if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
         final cleanJson = text.substring(startIndex, endIndex + 1);
         final json = jsonDecode(cleanJson);
         return jsonEncode(json); // Return normalized JSON string
      } else {
         throw Exception("No valid JSON found in response");
      }
    } catch (e) {
      // Return a fallback error JSON
      return jsonEncode({
        "title": "Analysis Failed",
        "score": 0,
        "riskLabel": "Error",
        "riskDescription": "Failed to analyze document: $e",
        "riskColor": "#808080",
        "summaryPoints": ["Could not analyze document."],
        "redFlags": []
      });
    }
  }

  Future<Map<String, String>> generateDraft({
    required String draftType,
    required String jurisdiction,
    required String keyParties,
    required String keyTerms,
    String? additionalInstructions,
  }) async {
    if (mockInstance != null) {
      // Return a simple mock if needed, but we don't strictly need to mock this for now unless testing
      return {
        "title": "Mock Draft",
        "content": "This is a mock draft content.",
      };
    }

    final prompt = '''
    You are an expert legal drafter.
    Create a legal document draft based on the following requirements:

    Type: $draftType
    Jurisdiction: $jurisdiction
    Key Parties: $keyParties
    Key Terms: $keyTerms
    ${additionalInstructions != null ? "Additional Instructions: $additionalInstructions" : ""}

    Instructions:
    1. Create a professional, legally sound draft suitable for the jurisdiction.
    2. Use placeholders like [Date], [Amount] where specific details are missing.
    3. Ensure clear formatting.

    Output Format (JSON):
    {
      "title": "A suitable title for the document",
      "content": "The full text of the document in Markdown format (use # for headings, ** for bold, etc.)"
    }
    ''';

    try {
      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      if (response.text == null) {
        throw Exception('Empty response from Gemini');
      }

      final text = response.text!;
      final startIndex = text.indexOf('{');
      final endIndex = text.lastIndexOf('}');

      if (startIndex != -1 && endIndex != -1 && endIndex > startIndex) {
        final cleanJson = text.substring(startIndex, endIndex + 1);
        final json = jsonDecode(cleanJson);
        return {
          "title": json['title'] ?? "Untitled Draft",
          "content": json['content'] ?? "No content generated.",
        };
      } else {
         throw Exception("No valid JSON found in response");
      }
    } catch (e) {
      return {
        "title": "Error Generating Draft",
        "content": "Failed to generate draft: $e. Please try again.",
      };
    }
  }
}
