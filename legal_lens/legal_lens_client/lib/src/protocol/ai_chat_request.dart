/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class AiChatRequest implements _i1.SerializableModel {
  AiChatRequest._({
    required this.userInput,
    this.contextId,
    this.sessionId,
    this.docId,
    this.language,
    this.newDocContent,
    this.newDocName,
  });

  factory AiChatRequest({
    required String userInput,
    String? contextId,
    String? sessionId,
    int? docId,
    String? language,
    String? newDocContent,
    String? newDocName,
  }) = _AiChatRequestImpl;

  factory AiChatRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiChatRequest(
      userInput: jsonSerialization['userInput'] as String,
      contextId: jsonSerialization['contextId'] as String?,
      sessionId: jsonSerialization['sessionId'] as String?,
      docId: jsonSerialization['docId'] as int?,
      language: jsonSerialization['language'] as String?,
      newDocContent: jsonSerialization['newDocContent'] as String?,
      newDocName: jsonSerialization['newDocName'] as String?,
    );
  }

  String userInput;

  String? contextId;

  String? sessionId;

  int? docId;

  String? language;

  String? newDocContent;

  String? newDocName;

  /// Returns a shallow copy of this [AiChatRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiChatRequest copyWith({
    String? userInput,
    String? contextId,
    String? sessionId,
    int? docId,
    String? language,
    String? newDocContent,
    String? newDocName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiChatRequest',
      'userInput': userInput,
      if (contextId != null) 'contextId': contextId,
      if (sessionId != null) 'sessionId': sessionId,
      if (docId != null) 'docId': docId,
      if (language != null) 'language': language,
      if (newDocContent != null) 'newDocContent': newDocContent,
      if (newDocName != null) 'newDocName': newDocName,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AiChatRequestImpl extends AiChatRequest {
  _AiChatRequestImpl({
    required String userInput,
    String? contextId,
    String? sessionId,
    int? docId,
    String? language,
    String? newDocContent,
    String? newDocName,
  }) : super._(
         userInput: userInput,
         contextId: contextId,
         sessionId: sessionId,
         docId: docId,
         language: language,
         newDocContent: newDocContent,
         newDocName: newDocName,
       );

  /// Returns a shallow copy of this [AiChatRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiChatRequest copyWith({
    String? userInput,
    Object? contextId = _Undefined,
    Object? sessionId = _Undefined,
    Object? docId = _Undefined,
    Object? language = _Undefined,
    Object? newDocContent = _Undefined,
    Object? newDocName = _Undefined,
  }) {
    return AiChatRequest(
      userInput: userInput ?? this.userInput,
      contextId: contextId is String? ? contextId : this.contextId,
      sessionId: sessionId is String? ? sessionId : this.sessionId,
      docId: docId is int? ? docId : this.docId,
      language: language is String? ? language : this.language,
      newDocContent: newDocContent is String?
          ? newDocContent
          : this.newDocContent,
      newDocName: newDocName is String? ? newDocName : this.newDocName,
    );
  }
}
