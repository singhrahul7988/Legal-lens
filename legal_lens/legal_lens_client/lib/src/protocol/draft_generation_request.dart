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

abstract class DraftGenerationRequest implements _i1.SerializableModel {
  DraftGenerationRequest._({
    required this.draftType,
    required this.jurisdiction,
    required this.keyParties,
    required this.keyTerms,
    this.additionalInstructions,
  });

  factory DraftGenerationRequest({
    required String draftType,
    required String jurisdiction,
    required String keyParties,
    required String keyTerms,
    String? additionalInstructions,
  }) = _DraftGenerationRequestImpl;

  factory DraftGenerationRequest.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DraftGenerationRequest(
      draftType: jsonSerialization['draftType'] as String,
      jurisdiction: jsonSerialization['jurisdiction'] as String,
      keyParties: jsonSerialization['keyParties'] as String,
      keyTerms: jsonSerialization['keyTerms'] as String,
      additionalInstructions:
          jsonSerialization['additionalInstructions'] as String?,
    );
  }

  String draftType;

  String jurisdiction;

  String keyParties;

  String keyTerms;

  String? additionalInstructions;

  /// Returns a shallow copy of this [DraftGenerationRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DraftGenerationRequest copyWith({
    String? draftType,
    String? jurisdiction,
    String? keyParties,
    String? keyTerms,
    String? additionalInstructions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DraftGenerationRequest',
      'draftType': draftType,
      'jurisdiction': jurisdiction,
      'keyParties': keyParties,
      'keyTerms': keyTerms,
      if (additionalInstructions != null)
        'additionalInstructions': additionalInstructions,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DraftGenerationRequestImpl extends DraftGenerationRequest {
  _DraftGenerationRequestImpl({
    required String draftType,
    required String jurisdiction,
    required String keyParties,
    required String keyTerms,
    String? additionalInstructions,
  }) : super._(
         draftType: draftType,
         jurisdiction: jurisdiction,
         keyParties: keyParties,
         keyTerms: keyTerms,
         additionalInstructions: additionalInstructions,
       );

  /// Returns a shallow copy of this [DraftGenerationRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DraftGenerationRequest copyWith({
    String? draftType,
    String? jurisdiction,
    String? keyParties,
    String? keyTerms,
    Object? additionalInstructions = _Undefined,
  }) {
    return DraftGenerationRequest(
      draftType: draftType ?? this.draftType,
      jurisdiction: jurisdiction ?? this.jurisdiction,
      keyParties: keyParties ?? this.keyParties,
      keyTerms: keyTerms ?? this.keyTerms,
      additionalInstructions: additionalInstructions is String?
          ? additionalInstructions
          : this.additionalInstructions,
    );
  }
}
