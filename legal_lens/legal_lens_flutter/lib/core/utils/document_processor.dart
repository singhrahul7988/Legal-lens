import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:archive/archive.dart';
import 'package:xml/xml.dart';

class DocumentProcessor {
  static Future<String> extractContent({
    required String name,
    Uint8List? bytes,
    String? path,
  }) async {
    String content = "Content could not be read.";
    
    try {
      if (bytes != null) {
        // Priority: Use bytes (works for Web & Mobile if picked via FilePicker)
        if (name.toLowerCase().endsWith('.pdf')) {
          // Extract text from PDF bytes
          final PdfDocument document = PdfDocument(inputBytes: bytes);
          String text = PdfTextExtractor(document).extractText();
          document.dispose();
          content = text.trim().isEmpty ? "PDF scanned or empty. No text found." : text;
        } else if (name.toLowerCase().endsWith('.docx')) {
          // Extract text from DOCX bytes
          try {
            final archive = ZipDecoder().decodeBytes(bytes);
            final xmlFile = archive.findFile('word/document.xml');
            if (xmlFile != null) {
              final xmlContent = utf8.decode(xmlFile.content);
              final document = XmlDocument.parse(xmlContent);
              content = document.findAllElements('w:t').map((node) => node.innerText).join(' ');
              if (content.trim().isEmpty) content = "DOCX empty or no text found.";
            } else {
              content = "Invalid DOCX format: missing document.xml";
            }
          } catch (e) {
             content = "Error parsing DOCX: $e";
          }
        } else if (['.jpg', '.jpeg', '.png'].any((ext) => name.toLowerCase().endsWith(ext))) {
           // Image: Convert to Base64 Data URI for Server Multimodal processing
           final mimeType = name.toLowerCase().endsWith('.png') ? 'image/png' : 'image/jpeg';
           final base64Data = base64Encode(bytes);
           content = "data:$mimeType;base64,$base64Data";
        } else {
           // Assume text/utf8 for other types for now (txt, json, etc.)
           try {
             content = utf8.decode(bytes);
           } catch (_) {
             content = "Binary file (non-PDF/Image) detected. Text extraction not supported yet.";
           }
        }
      } else if (!kIsWeb && path != null && !path.startsWith('http')) {
         // Fallback to File I/O for native if bytes are missing
         // Note: This only works for text files unless we implement PDF/DOCX reading from File object too
         // Ideally, caller should provide bytes.
         content = await File(path).readAsString();
      }
    } catch (e) {
      debugPrint("Error reading file: $e");
      content = "Error reading document content: $e";
    }
    
    return content;
  }
}
