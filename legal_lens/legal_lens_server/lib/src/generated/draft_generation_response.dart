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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class DraftGenerationResponse
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DraftGenerationResponse._({
    required this.content,
    required this.title,
  });

  factory DraftGenerationResponse({
    required String content,
    required String title,
  }) = _DraftGenerationResponseImpl;

  factory DraftGenerationResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DraftGenerationResponse(
      content: jsonSerialization['content'] as String,
      title: jsonSerialization['title'] as String,
    );
  }

  String content;

  String title;

  /// Returns a shallow copy of this [DraftGenerationResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DraftGenerationResponse copyWith({
    String? content,
    String? title,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DraftGenerationResponse',
      'content': content,
      'title': title,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DraftGenerationResponse',
      'content': content,
      'title': title,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DraftGenerationResponseImpl extends DraftGenerationResponse {
  _DraftGenerationResponseImpl({
    required String content,
    required String title,
  }) : super._(
         content: content,
         title: title,
       );

  /// Returns a shallow copy of this [DraftGenerationResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DraftGenerationResponse copyWith({
    String? content,
    String? title,
  }) {
    return DraftGenerationResponse(
      content: content ?? this.content,
      title: title ?? this.title,
    );
  }
}
