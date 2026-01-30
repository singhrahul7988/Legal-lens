import 'package:flutter/material.dart';
import 'dart:typed_data';

enum DocumentStatus {
  uploading,
  uploaded,
  analyzing,
  analyzed,
  error,
}

enum DocumentType {
  rentalAgreement,
  hospitalBill,
  contract,
  other,
}

class DocumentModel {
  final String id;
  final int? serverId; // ID from Serverpod
  final String name;
  final String path; // Local path or URL
  final Uint8List? bytes; // File bytes for Web
  final int size;
  final DateTime uploadDate;
  DocumentStatus status;
  DocumentType type;
  AnalysisResultModel? analysisResult;
  List<ChatMessageModel> chatHistory;

  DocumentModel({
    required this.id,
    this.serverId,
    required this.name,
    required this.path,
    this.bytes,
    required this.size,
    required this.uploadDate,
    this.status = DocumentStatus.uploaded,
    this.type = DocumentType.other,
    this.analysisResult,
    this.chatHistory = const [],
  });
}

class AnalysisResultModel {
  final String title;
  final int score;
  final String riskLabel;
  final String riskDescription;
  final Color riskColor;
  final List<String> summaryPoints; // Simplified for now
  final List<RedFlagModel> redFlags;
  
  // Hospital Bill Specifics
  final double? totalAmount;
  final double? insuranceCovered;
  final double? outOfPocket;

  AnalysisResultModel({
    required this.title,
    required this.score,
    required this.riskLabel,
    required this.riskDescription,
    required this.riskColor,
    this.summaryPoints = const [],
    this.redFlags = const [],
    this.totalAmount,
    this.insuranceCovered,
    this.outOfPocket,
  });

  factory AnalysisResultModel.fromJson(Map<String, dynamic> json) {
    return AnalysisResultModel(
      title: json['title'] ?? 'Untitled Analysis',
      score: json['score'] is int ? json['score'] : int.tryParse(json['score'].toString()) ?? 0,
      riskLabel: json['riskLabel'] ?? 'Unknown',
      riskDescription: json['riskDescription'] ?? '',
      riskColor: _parseColor(json['riskColor']),
      summaryPoints: List<String>.from(json['summaryPoints'] ?? []),
      redFlags: (json['redFlags'] as List<dynamic>?)
              ?.map((e) => RedFlagModel.fromJson(e))
              .toList() ??
          [],
      totalAmount: json['totalAmount'] != null ? (json['totalAmount'] as num).toDouble() : null,
      insuranceCovered: json['insuranceCovered'] != null ? (json['insuranceCovered'] as num).toDouble() : null,
      outOfPocket: json['outOfPocket'] != null ? (json['outOfPocket'] as num).toDouble() : null,
    );
  }

  static Color _parseColor(String? hexString) {
    if (hexString == null) return Colors.grey;
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch (e) {
      return Colors.grey;
    }
  }
}

class RedFlagModel {
  final String title;
  final String description;
  final String severity; // High, Medium, Low

  RedFlagModel({
    required this.title,
    required this.description,
    required this.severity,
  });

  factory RedFlagModel.fromJson(Map<String, dynamic> json) {
    return RedFlagModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      severity: json['severity'] ?? 'Low',
    );
  }
}

class ChatMessageModel {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessageModel({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}