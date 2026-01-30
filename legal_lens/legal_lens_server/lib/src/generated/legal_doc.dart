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
import 'doc_status.dart' as _i2;
import 'doc_type.dart' as _i3;

abstract class LegalDoc
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = LegalDocTable();

  static const db = LegalDocRepository._();

  @override
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

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static LegalDocInclude include() {
    return LegalDocInclude._();
  }

  static LegalDocIncludeList includeList({
    _i1.WhereExpressionBuilder<LegalDocTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LegalDocTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LegalDocTable>? orderByList,
    LegalDocInclude? include,
  }) {
    return LegalDocIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LegalDoc.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(LegalDoc.t),
      include: include,
    );
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

class LegalDocUpdateTable extends _i1.UpdateTable<LegalDocTable> {
  LegalDocUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> sessionId(String? value) => _i1.ColumnValue(
    table.sessionId,
    value,
  );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> originalFileUrl(String? value) =>
      _i1.ColumnValue(
        table.originalFileUrl,
        value,
      );

  _i1.ColumnValue<String, String> content(String? value) => _i1.ColumnValue(
    table.content,
    value,
  );

  _i1.ColumnValue<String, String> summary(String? value) => _i1.ColumnValue(
    table.summary,
    value,
  );

  _i1.ColumnValue<String, String> analysisJson(String? value) =>
      _i1.ColumnValue(
        table.analysisJson,
        value,
      );

  _i1.ColumnValue<_i2.DocStatus, _i2.DocStatus> status(_i2.DocStatus value) =>
      _i1.ColumnValue(
        table.status,
        value,
      );

  _i1.ColumnValue<_i3.DocType, _i3.DocType> type(_i3.DocType value) =>
      _i1.ColumnValue(
        table.type,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class LegalDocTable extends _i1.Table<int?> {
  LegalDocTable({super.tableRelation}) : super(tableName: 'legal_doc') {
    updateTable = LegalDocUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    sessionId = _i1.ColumnString(
      'sessionId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    originalFileUrl = _i1.ColumnString(
      'originalFileUrl',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    summary = _i1.ColumnString(
      'summary',
      this,
    );
    analysisJson = _i1.ColumnString(
      'analysisJson',
      this,
    );
    status = _i1.ColumnEnum(
      'status',
      this,
      _i1.EnumSerialization.byName,
    );
    type = _i1.ColumnEnum(
      'type',
      this,
      _i1.EnumSerialization.byName,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final LegalDocUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnString sessionId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString originalFileUrl;

  late final _i1.ColumnString content;

  late final _i1.ColumnString summary;

  late final _i1.ColumnString analysisJson;

  late final _i1.ColumnEnum<_i2.DocStatus> status;

  late final _i1.ColumnEnum<_i3.DocType> type;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    sessionId,
    title,
    originalFileUrl,
    content,
    summary,
    analysisJson,
    status,
    type,
    createdAt,
    updatedAt,
  ];
}

class LegalDocInclude extends _i1.IncludeObject {
  LegalDocInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => LegalDoc.t;
}

class LegalDocIncludeList extends _i1.IncludeList {
  LegalDocIncludeList._({
    _i1.WhereExpressionBuilder<LegalDocTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(LegalDoc.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => LegalDoc.t;
}

class LegalDocRepository {
  const LegalDocRepository._();

  /// Returns a list of [LegalDoc]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<LegalDoc>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LegalDocTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LegalDocTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LegalDocTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<LegalDoc>(
      where: where?.call(LegalDoc.t),
      orderBy: orderBy?.call(LegalDoc.t),
      orderByList: orderByList?.call(LegalDoc.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [LegalDoc] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<LegalDoc?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LegalDocTable>? where,
    int? offset,
    _i1.OrderByBuilder<LegalDocTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<LegalDocTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<LegalDoc>(
      where: where?.call(LegalDoc.t),
      orderBy: orderBy?.call(LegalDoc.t),
      orderByList: orderByList?.call(LegalDoc.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [LegalDoc] by its [id] or null if no such row exists.
  Future<LegalDoc?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<LegalDoc>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [LegalDoc]s in the list and returns the inserted rows.
  ///
  /// The returned [LegalDoc]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<LegalDoc>> insert(
    _i1.Session session,
    List<LegalDoc> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<LegalDoc>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [LegalDoc] and returns the inserted row.
  ///
  /// The returned [LegalDoc] will have its `id` field set.
  Future<LegalDoc> insertRow(
    _i1.Session session,
    LegalDoc row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<LegalDoc>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [LegalDoc]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<LegalDoc>> update(
    _i1.Session session,
    List<LegalDoc> rows, {
    _i1.ColumnSelections<LegalDocTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<LegalDoc>(
      rows,
      columns: columns?.call(LegalDoc.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LegalDoc]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<LegalDoc> updateRow(
    _i1.Session session,
    LegalDoc row, {
    _i1.ColumnSelections<LegalDocTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<LegalDoc>(
      row,
      columns: columns?.call(LegalDoc.t),
      transaction: transaction,
    );
  }

  /// Updates a single [LegalDoc] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<LegalDoc?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<LegalDocUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<LegalDoc>(
      id,
      columnValues: columnValues(LegalDoc.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [LegalDoc]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<LegalDoc>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<LegalDocUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<LegalDocTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<LegalDocTable>? orderBy,
    _i1.OrderByListBuilder<LegalDocTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<LegalDoc>(
      columnValues: columnValues(LegalDoc.t.updateTable),
      where: where(LegalDoc.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(LegalDoc.t),
      orderByList: orderByList?.call(LegalDoc.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [LegalDoc]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<LegalDoc>> delete(
    _i1.Session session,
    List<LegalDoc> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<LegalDoc>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [LegalDoc].
  Future<LegalDoc> deleteRow(
    _i1.Session session,
    LegalDoc row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<LegalDoc>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<LegalDoc>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<LegalDocTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<LegalDoc>(
      where: where(LegalDoc.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<LegalDocTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<LegalDoc>(
      where: where?.call(LegalDoc.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
