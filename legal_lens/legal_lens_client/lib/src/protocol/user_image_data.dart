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

abstract class UserImageData implements _i1.SerializableModel {
  UserImageData._({
    this.id,
    required this.userId,
    required this.data,
    required this.mimeType,
  });

  factory UserImageData({
    int? id,
    required _i1.UuidValue userId,
    required String data,
    required String mimeType,
  }) = _UserImageDataImpl;

  factory UserImageData.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserImageData(
      id: jsonSerialization['id'] as int?,
      userId: _i1.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      data: jsonSerialization['data'] as String,
      mimeType: jsonSerialization['mimeType'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _i1.UuidValue userId;

  String data;

  String mimeType;

  /// Returns a shallow copy of this [UserImageData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserImageData copyWith({
    int? id,
    _i1.UuidValue? userId,
    String? data,
    String? mimeType,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserImageData',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'data': data,
      'mimeType': mimeType,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImageDataImpl extends UserImageData {
  _UserImageDataImpl({
    int? id,
    required _i1.UuidValue userId,
    required String data,
    required String mimeType,
  }) : super._(
         id: id,
         userId: userId,
         data: data,
         mimeType: mimeType,
       );

  /// Returns a shallow copy of this [UserImageData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserImageData copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? userId,
    String? data,
    String? mimeType,
  }) {
    return UserImageData(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      data: data ?? this.data,
      mimeType: mimeType ?? this.mimeType,
    );
  }
}
