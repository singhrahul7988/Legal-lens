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
import 'doc_status.dart' as _i2;
import 'doc_type.dart' as _i3;

abstract class LegalDoc implements _i1.SerializableModel {
  LegalDoc._({
    this.id,
    required this.userId,
    this.sessionId,
    required this.title,
    this.originalFileUrl,
    this.content,
    this.summary,
    this.analysisJson,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LegalDoc({
    int? id,
    required _i1.UuidValue userId,
    String? sessionId,
    required String title,
    String? originalFileUrl,
    String? content,
    String? summary,
    String? analysisJson,
    required _i2.DocStatus status,
    required _i3.DocType type,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _LegalDocImpl;

  factory LegalDoc.fromJson(Map<String, dynamic> jsonSerialization) {
    return LegalDoc(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      sessionId: jsonSerialization['sessionId'] as String?,
      title: jsonSerialization['title'] as String,
      originalFileUrl: jsonSerialization['originalFileUrl'] as String?,
      content: jsonSerialization['content'] as String?,
      summary: jsonSerialization['summary'] as String?,
      analysisJson: jsonSerialization['analysisJson'] as String?,
      status: _i2.DocStatus.fromJson((jsonSerialization['status'] as String)),
      type: _i3.DocType.fromJson((jsonSerialization['type'] as String)),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  String? sessionId;

  String title;

  String? originalFileUrl;

  String? content;

  String? summary;

  String? analysisJson;

  _i2.DocStatus status;

  _i3.DocType type;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [LegalDoc]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LegalDoc copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? sessionId,
    String? title,
    String? originalFileUrl,
    String? content,
    String? summary,
    String? analysisJson,
    _i2.DocStatus? status,
    _i3.DocType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LegalDoc',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      if (sessionId != null) 'sessionId': sessionId,
      'title': title,
      if (originalFileUrl != null) 'originalFileUrl': originalFileUrl,
      if (content != null) 'content': content,
      if (summary != null) 'summary': summary,
      if (analysisJson != null) 'analysisJson': analysisJson,
      'status': status.toJson(),
      'type': type.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LegalDocImpl extends LegalDoc {
  _LegalDocImpl({
    int? id,
    required _i1.UuidValue userId,
    String? sessionId,
    required String title,
    String? originalFileUrl,
    String? content,
    String? summary,
    String? analysisJson,
    required _i2.DocStatus status,
    required _i3.DocType type,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         sessionId: sessionId,
         title: title,
         originalFileUrl: originalFileUrl,
         content: content,
         summary: summary,
         analysisJson: analysisJson,
         status: status,
         type: type,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [LegalDoc]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LegalDoc copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    Object? sessionId = _Undefined,
    String? title,
    Object? originalFileUrl = _Undefined,
    Object? content = _Undefined,
    Object? summary = _Undefined,
    Object? analysisJson = _Undefined,
    _i2.DocStatus? status,
    _i3.DocType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return LegalDoc(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      sessionId: sessionId is String? ? sessionId : this.sessionId,
      title: title ?? this.title,
      originalFileUrl: originalFileUrl is String?
          ? originalFileUrl
          : this.originalFileUrl,
      content: content is String? ? content : this.content,
      summary: summary is String? ? summary : this.summary,
      analysisJson: analysisJson is String? ? analysisJson : this.analysisJson,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
