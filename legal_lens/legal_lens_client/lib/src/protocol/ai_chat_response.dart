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
import 'package:legal_lens_client/src/protocol/protocol.dart' as _i2;

abstract class AiChatResponse implements _i1.SerializableModel {
  AiChatResponse._({
    required this.userInputCopy,
    required this.aiResponse,
    required this.suggestedFollowups,
    required this.contextId,
  });

  factory AiChatResponse({
    required String userInputCopy,
    required String aiResponse,
    required List<String> suggestedFollowups,
    required String contextId,
  }) = _AiChatResponseImpl;

  factory AiChatResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiChatResponse(
      userInputCopy: jsonSerialization['userInputCopy'] as String,
      aiResponse: jsonSerialization['aiResponse'] as String,
      suggestedFollowups: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['suggestedFollowups'],
      ),
      contextId: jsonSerialization['contextId'] as String,
    );
  }

  String userInputCopy;

  String aiResponse;

  List<String> suggestedFollowups;

  String contextId;

  /// Returns a shallow copy of this [AiChatResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiChatResponse copyWith({
    String? userInputCopy,
    String? aiResponse,
    List<String>? suggestedFollowups,
    String? contextId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiChatResponse',
      'userInputCopy': userInputCopy,
      'aiResponse': aiResponse,
      'suggestedFollowups': suggestedFollowups.toJson(),
      'contextId': contextId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AiChatResponseImpl extends AiChatResponse {
  _AiChatResponseImpl({
    required String userInputCopy,
    required String aiResponse,
    required List<String> suggestedFollowups,
    required String contextId,
  }) : super._(
         userInputCopy: userInputCopy,
         aiResponse: aiResponse,
         suggestedFollowups: suggestedFollowups,
         contextId: contextId,
       );

  /// Returns a shallow copy of this [AiChatResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiChatResponse copyWith({
    String? userInputCopy,
    String? aiResponse,
    List<String>? suggestedFollowups,
    String? contextId,
  }) {
    return AiChatResponse(
      userInputCopy: userInputCopy ?? this.userInputCopy,
      aiResponse: aiResponse ?? this.aiResponse,
      suggestedFollowups:
          suggestedFollowups ??
          this.suggestedFollowups.map((e0) => e0).toList(),
      contextId: contextId ?? this.contextId,
    );
  }
}
