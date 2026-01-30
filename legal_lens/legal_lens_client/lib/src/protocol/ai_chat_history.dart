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
import 'ai_chat_history_entry.dart' as _i2;
import 'package:legal_lens_client/src/protocol/protocol.dart' as _i3;

abstract class AiChatHistory implements _i1.SerializableModel {
  AiChatHistory._({required this.entries});

  factory AiChatHistory({required List<_i2.AiChatHistoryEntry> entries}) =
      _AiChatHistoryImpl;

  factory AiChatHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiChatHistory(
      entries: _i3.Protocol().deserialize<List<_i2.AiChatHistoryEntry>>(
        jsonSerialization['entries'],
      ),
    );
  }

  List<_i2.AiChatHistoryEntry> entries;

  /// Returns a shallow copy of this [AiChatHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AiChatHistory copyWith({List<_i2.AiChatHistoryEntry>? entries});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiChatHistory',
      'entries': entries.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AiChatHistoryImpl extends AiChatHistory {
  _AiChatHistoryImpl({required List<_i2.AiChatHistoryEntry> entries})
    : super._(entries: entries);

  /// Returns a shallow copy of this [AiChatHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AiChatHistory copyWith({List<_i2.AiChatHistoryEntry>? entries}) {
    return AiChatHistory(
      entries: entries ?? this.entries.map((e0) => e0.copyWith()).toList(),
    );
  }
}
