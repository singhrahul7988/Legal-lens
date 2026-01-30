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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i4;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i5;
import 'ai_chat_history.dart' as _i6;
import 'ai_chat_history_entry.dart' as _i7;
import 'ai_chat_request.dart' as _i8;
import 'ai_chat_response.dart' as _i9;
import 'doc_status.dart' as _i10;
import 'doc_type.dart' as _i11;
import 'draft_generation_request.dart' as _i12;
import 'draft_generation_response.dart' as _i13;
import 'legal_doc.dart' as _i14;
import 'user_image_data.dart' as _i15;
import 'package:legal_lens_server/src/generated/legal_doc.dart' as _i16;
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

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'legal_doc',
      dartName: 'LegalDoc',
      schema: 'public',
      module: 'legal_lens',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'legal_doc_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'sessionId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'originalFileUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'summary',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'analysisJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DocStatus',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DocType',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'legal_doc_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'session_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'sessionId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_image_data',
      dartName: 'UserImageData',
      schema: 'public',
      module: 'legal_lens',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_image_data_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'data',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'mimeType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_image_data_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i5.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

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

    if (t == _i6.AiChatHistory) {
      return _i6.AiChatHistory.fromJson(data) as T;
    }
    if (t == _i7.AiChatHistoryEntry) {
      return _i7.AiChatHistoryEntry.fromJson(data) as T;
    }
    if (t == _i8.AiChatRequest) {
      return _i8.AiChatRequest.fromJson(data) as T;
    }
    if (t == _i9.AiChatResponse) {
      return _i9.AiChatResponse.fromJson(data) as T;
    }
    if (t == _i10.DocStatus) {
      return _i10.DocStatus.fromJson(data) as T;
    }
    if (t == _i11.DocType) {
      return _i11.DocType.fromJson(data) as T;
    }
    if (t == _i12.DraftGenerationRequest) {
      return _i12.DraftGenerationRequest.fromJson(data) as T;
    }
    if (t == _i13.DraftGenerationResponse) {
      return _i13.DraftGenerationResponse.fromJson(data) as T;
    }
    if (t == _i14.LegalDoc) {
      return _i14.LegalDoc.fromJson(data) as T;
    }
    if (t == _i15.UserImageData) {
      return _i15.UserImageData.fromJson(data) as T;
    }
    if (t == _i1.getType<_i6.AiChatHistory?>()) {
      return (data != null ? _i6.AiChatHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.AiChatHistoryEntry?>()) {
      return (data != null ? _i7.AiChatHistoryEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.AiChatRequest?>()) {
      return (data != null ? _i8.AiChatRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.AiChatResponse?>()) {
      return (data != null ? _i9.AiChatResponse.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.DocStatus?>()) {
      return (data != null ? _i10.DocStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.DocType?>()) {
      return (data != null ? _i11.DocType.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.DraftGenerationRequest?>()) {
      return (data != null ? _i12.DraftGenerationRequest.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.DraftGenerationResponse?>()) {
      return (data != null ? _i13.DraftGenerationResponse.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.LegalDoc?>()) {
      return (data != null ? _i14.LegalDoc.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.UserImageData?>()) {
      return (data != null ? _i15.UserImageData.fromJson(data) : null) as T;
    }
    if (t == List<_i7.AiChatHistoryEntry>) {
      return (data as List)
              .map((e) => deserialize<_i7.AiChatHistoryEntry>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i16.LegalDoc>) {
      return (data as List).map((e) => deserialize<_i16.LegalDoc>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i5.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i6.AiChatHistory => 'AiChatHistory',
      _i7.AiChatHistoryEntry => 'AiChatHistoryEntry',
      _i8.AiChatRequest => 'AiChatRequest',
      _i9.AiChatResponse => 'AiChatResponse',
      _i10.DocStatus => 'DocStatus',
      _i11.DocType => 'DocType',
      _i12.DraftGenerationRequest => 'DraftGenerationRequest',
      _i13.DraftGenerationResponse => 'DraftGenerationResponse',
      _i14.LegalDoc => 'LegalDoc',
      _i15.UserImageData => 'UserImageData',
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
      case _i6.AiChatHistory():
        return 'AiChatHistory';
      case _i7.AiChatHistoryEntry():
        return 'AiChatHistoryEntry';
      case _i8.AiChatRequest():
        return 'AiChatRequest';
      case _i9.AiChatResponse():
        return 'AiChatResponse';
      case _i10.DocStatus():
        return 'DocStatus';
      case _i11.DocType():
        return 'DocType';
      case _i12.DraftGenerationRequest():
        return 'DraftGenerationRequest';
      case _i13.DraftGenerationResponse():
        return 'DraftGenerationResponse';
      case _i14.LegalDoc():
        return 'LegalDoc';
      case _i15.UserImageData():
        return 'UserImageData';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    className = _i5.Protocol().getClassNameForObject(data);
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
      return deserialize<_i6.AiChatHistory>(data['data']);
    }
    if (dataClassName == 'AiChatHistoryEntry') {
      return deserialize<_i7.AiChatHistoryEntry>(data['data']);
    }
    if (dataClassName == 'AiChatRequest') {
      return deserialize<_i8.AiChatRequest>(data['data']);
    }
    if (dataClassName == 'AiChatResponse') {
      return deserialize<_i9.AiChatResponse>(data['data']);
    }
    if (dataClassName == 'DocStatus') {
      return deserialize<_i10.DocStatus>(data['data']);
    }
    if (dataClassName == 'DocType') {
      return deserialize<_i11.DocType>(data['data']);
    }
    if (dataClassName == 'DraftGenerationRequest') {
      return deserialize<_i12.DraftGenerationRequest>(data['data']);
    }
    if (dataClassName == 'DraftGenerationResponse') {
      return deserialize<_i13.DraftGenerationResponse>(data['data']);
    }
    if (dataClassName == 'LegalDoc') {
      return deserialize<_i14.LegalDoc>(data['data']);
    }
    if (dataClassName == 'UserImageData') {
      return deserialize<_i15.UserImageData>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i4.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i5.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i5.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i14.LegalDoc:
        return _i14.LegalDoc.t;
      case _i15.UserImageData:
        return _i15.UserImageData.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'legal_lens';

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
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i5.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
