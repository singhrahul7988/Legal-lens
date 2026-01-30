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

abstract class UserImageData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = UserImageDataTable();

  static const db = UserImageDataRepository._();

  @override
  int? id;

  _i1.UuidValue userId;

  String data;

  String mimeType;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserImageData',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'data': data,
      'mimeType': mimeType,
    };
  }

  static UserImageDataInclude include() {
    return UserImageDataInclude._();
  }

  static UserImageDataIncludeList includeList({
    _i1.WhereExpressionBuilder<UserImageDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserImageDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserImageDataTable>? orderByList,
    UserImageDataInclude? include,
  }) {
    return UserImageDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserImageData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserImageData.t),
      include: include,
    );
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

class UserImageDataUpdateTable extends _i1.UpdateTable<UserImageDataTable> {
  UserImageDataUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.userId,
        value,
      );

  _i1.ColumnValue<String, String> data(String value) => _i1.ColumnValue(
    table.data,
    value,
  );

  _i1.ColumnValue<String, String> mimeType(String value) => _i1.ColumnValue(
    table.mimeType,
    value,
  );
}

class UserImageDataTable extends _i1.Table<int?> {
  UserImageDataTable({super.tableRelation})
    : super(tableName: 'user_image_data') {
    updateTable = UserImageDataUpdateTable(this);
    userId = _i1.ColumnUuid(
      'userId',
      this,
    );
    data = _i1.ColumnString(
      'data',
      this,
    );
    mimeType = _i1.ColumnString(
      'mimeType',
      this,
    );
  }

  late final UserImageDataUpdateTable updateTable;

  late final _i1.ColumnUuid userId;

  late final _i1.ColumnString data;

  late final _i1.ColumnString mimeType;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    data,
    mimeType,
  ];
}

class UserImageDataInclude extends _i1.IncludeObject {
  UserImageDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserImageData.t;
}

class UserImageDataIncludeList extends _i1.IncludeList {
  UserImageDataIncludeList._({
    _i1.WhereExpressionBuilder<UserImageDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserImageData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserImageData.t;
}

class UserImageDataRepository {
  const UserImageDataRepository._();

  /// Returns a list of [UserImageData]s matching the given query parameters.
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
  Future<List<UserImageData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserImageDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserImageDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserImageDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<UserImageData>(
      where: where?.call(UserImageData.t),
      orderBy: orderBy?.call(UserImageData.t),
      orderByList: orderByList?.call(UserImageData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [UserImageData] matching the given query parameters.
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
  Future<UserImageData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserImageDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserImageDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserImageDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<UserImageData>(
      where: where?.call(UserImageData.t),
      orderBy: orderBy?.call(UserImageData.t),
      orderByList: orderByList?.call(UserImageData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [UserImageData] by its [id] or null if no such row exists.
  Future<UserImageData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<UserImageData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [UserImageData]s in the list and returns the inserted rows.
  ///
  /// The returned [UserImageData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<UserImageData>> insert(
    _i1.Session session,
    List<UserImageData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<UserImageData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [UserImageData] and returns the inserted row.
  ///
  /// The returned [UserImageData] will have its `id` field set.
  Future<UserImageData> insertRow(
    _i1.Session session,
    UserImageData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserImageData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserImageData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserImageData>> update(
    _i1.Session session,
    List<UserImageData> rows, {
    _i1.ColumnSelections<UserImageDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserImageData>(
      rows,
      columns: columns?.call(UserImageData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserImageData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserImageData> updateRow(
    _i1.Session session,
    UserImageData row, {
    _i1.ColumnSelections<UserImageDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserImageData>(
      row,
      columns: columns?.call(UserImageData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserImageData] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserImageData?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<UserImageDataUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserImageData>(
      id,
      columnValues: columnValues(UserImageData.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserImageData]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserImageData>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserImageDataUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserImageDataTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserImageDataTable>? orderBy,
    _i1.OrderByListBuilder<UserImageDataTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserImageData>(
      columnValues: columnValues(UserImageData.t.updateTable),
      where: where(UserImageData.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserImageData.t),
      orderByList: orderByList?.call(UserImageData.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserImageData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserImageData>> delete(
    _i1.Session session,
    List<UserImageData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserImageData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserImageData].
  Future<UserImageData> deleteRow(
    _i1.Session session,
    UserImageData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserImageData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserImageData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserImageDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserImageData>(
      where: where(UserImageData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserImageDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserImageData>(
      where: where?.call(UserImageData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
