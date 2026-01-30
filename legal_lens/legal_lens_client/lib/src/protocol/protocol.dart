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
import 'ai_chat_history.dart' as _i2;
import 'ai_chat_history_entry.dart' as _i3;
import 'ai_chat_request.dart' as _i4;
import 'ai_chat_response.dart' as _i5;
import 'doc_status.dart' as _i6;
import 'doc_type.dart' as _i7;
import 'draft_generation_request.dart' as _i8;
import 'draft_generation_response.dart' as _i9;
import 'legal_doc.dart' as _i10;
import 'user_image_data.dart' as _i11;
import 'package:legal_lens_client/src/protocol/legal_doc.dart' as _i12;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i13;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i14;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i15;
export 'ai_chat_history.dart';
export 'ai_chat_history_entry.dart';
export 'ai_chat_request.dart';
export 'ai_chat_response.dart';
export 'doc_status.dart';
export 'doc_type.dart';
export 'draft_generation_request.dart';
export 'draft_generation_response.dart';
export 'legal_doc.dart';
export 'user_image_data.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AiChatHistory) {
      return _i2.AiChatHistory.fromJson(data) as T;
    }
    if (t == _i3.AiChatHistoryEntry) {
      return _i3.AiChatHistoryEntry.fromJson(data) as T;
    }
    if (t == _i4.AiChatRequest) {
      return _i4.AiChatRequest.fromJson(data) as T;
    }
    if (t == _i5.AiChatResponse) {
      return _i5.AiChatResponse.fromJson(data) as T;
    }
    if (t == _i6.DocStatus) {
      return _i6.DocStatus.fromJson(data) as T;
    }
    if (t == _i7.DocType) {
      return _i7.DocType.fromJson(data) as T;
    }
    if (t == _i8.DraftGenerationRequest) {
      return _i8.DraftGenerationRequest.fromJson(data) as T;
    }
    if (t == _i9.DraftGenerationResponse) {
      return _i9.DraftGenerationResponse.fromJson(data) as T;
    }
    if (t == _i10.LegalDoc) {
      return _i10.LegalDoc.fromJson(data) as T;
    }
    if (t == _i11.UserImageData) {
      return _i11.UserImageData.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AiChatHistory?>()) {
      return (data != null ? _i2.AiChatHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AiChatHistoryEntry?>()) {
      return (data != null ? _i3.AiChatHistoryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AiChatRequest?>()) {
      return (data != null ? _i4.AiChatRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AiChatResponse?>()) {
      return (data != null ? _i5.AiChatResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.DocStatus?>()) {
      return (data != null ? _i6.DocStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.DocType?>()) {
      return (data != null ? _i7.DocType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.DraftGenerationRequest?>()) {
      return (data != null ? _i8.DraftGenerationRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i9.DraftGenerationResponse?>()) {
      return (data != null ? _i9.DraftGenerationResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.LegalDoc?>()) {
      return (data != null ? _i10.LegalDoc.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.UserImageData?>()) {
      return (data != null ? _i11.UserImageData.fromJson(data) : null) as T;
    }
    if (t == List<_i3.AiChatHistoryEntry>) {
      return (data as List)
              .map((e) => deserialize<_i3.AiChatHistoryEntry>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i12.LegalDoc>) {
      return (data as List).map((e) => deserialize<_i12.LegalDoc>(e)).toList()
          as T;
    }
    try {
      return _i13.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i15.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AiChatHistory => 'AiChatHistory',
      _i3.AiChatHistoryEntry => 'AiChatHistoryEntry',
      _i4.AiChatRequest => 'AiChatRequest',
      _i5.AiChatResponse => 'AiChatResponse',
      _i6.DocStatus => 'DocStatus',
      _i7.DocType => 'DocType',
      _i8.DraftGenerationRequest => 'DraftGenerationRequest',
      _i9.DraftGenerationResponse => 'DraftGenerationResponse',
      _i10.LegalDoc => 'LegalDoc',
      _i11.UserImageData => 'UserImageData',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('legal_lens.', '');
    }

    switch (data) {
      case _i2.AiChatHistory():
        return 'AiChatHistory';
      case _i3.AiChatHistoryEntry():
        return 'AiChatHistoryEntry';
      case _i4.AiChatRequest():
        return 'AiChatRequest';
      case _i5.AiChatResponse():
        return 'AiChatResponse';
      case _i6.DocStatus():
        return 'DocStatus';
      case _i7.DocType():
        return 'DocType';
      case _i8.DraftGenerationRequest():
        return 'DraftGenerationRequest';
      case _i9.DraftGenerationResponse():
        return 'DraftGenerationResponse';
      case _i10.LegalDoc():
        return 'LegalDoc';
      case _i11.UserImageData():
        return 'UserImageData';
    }
    className = _i13.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    className = _i15.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AiChatHistory') {
      return deserialize<_i2.AiChatHistory>(data['data']);
    }
    if (dataClassName == 'AiChatHistoryEntry') {
      return deserialize<_i3.AiChatHistoryEntry>(data['data']);
    }
    if (dataClassName == 'AiChatRequest') {
      return deserialize<_i4.AiChatRequest>(data['data']);
    }
    if (dataClassName == 'AiChatResponse') {
      return deserialize<_i5.AiChatResponse>(data['data']);
    }
    if (dataClassName == 'DocStatus') {
      return deserialize<_i6.DocStatus>(data['data']);
    }
    if (dataClassName == 'DocType') {
      return deserialize<_i7.DocType>(data['data']);
    }
    if (dataClassName == 'DraftGenerationRequest') {
      return deserialize<_i8.DraftGenerationRequest>(data['data']);
    }
    if (dataClassName == 'DraftGenerationResponse') {
      return deserialize<_i9.DraftGenerationResponse>(data['data']);
    }
    if (dataClassName == 'LegalDoc') {
      return deserialize<_i10.LegalDoc>(data['data']);
    }
    if (dataClassName == 'UserImageData') {
      return deserialize<_i11.UserImageData>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i13.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i14.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i15.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i13.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i15.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
