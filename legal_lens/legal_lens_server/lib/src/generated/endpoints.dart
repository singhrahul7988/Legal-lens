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
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/ai_endpoint.dart' as _i4;
import '../endpoints/document_endpoint.dart' as _i5;
import '../endpoints/user_image_endpoint.dart' as _i6;
import 'package:legal_lens_server/src/generated/ai_chat_request.dart' as _i7;
import 'package:legal_lens_server/src/generated/draft_generation_request.dart'
    as _i8;
import 'package:legal_lens_server/src/generated/legal_doc.dart' as _i9;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i10;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i11;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i12;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'ai': _i4.AiEndpoint()
        ..initialize(
          server,
          'ai',
          null,
        ),
      'document': _i5.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'userImage': _i6.UserImageEndpoint()
        ..initialize(
          server,
          'userImage',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['ai'] = _i1.EndpointConnector(
      name: 'ai',
      endpoint: endpoints['ai']!,
      methodConnectors: {
        'chat': _i1.MethodConnector(
          name: 'chat',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i7.AiChatRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i4.AiEndpoint).chat(
                session,
                params['request'],
              ),
        ),
        'generateDraft': _i1.MethodConnector(
          name: 'generateDraft',
          params: {
            'request': _i1.ParameterDescription(
              name: 'request',
              type: _i1.getType<_i8.DraftGenerationRequest>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['ai'] as _i4.AiEndpoint).generateDraft(
                session,
                params['request'],
              ),
        ),
      },
    );
    connectors['document'] = _i1.EndpointConnector(
      name: 'document',
      endpoint: endpoints['document']!,
      methodConnectors: {
        'createDocument': _i1.MethodConnector(
          name: 'createDocument',
          params: {
            'doc': _i1.ParameterDescription(
              name: 'doc',
              type: _i1.getType<_i9.LegalDoc>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i5.DocumentEndpoint)
                  .createDocument(
                    session,
                    params['doc'],
                  ),
        ),
        'analyzeDocument': _i1.MethodConnector(
          name: 'analyzeDocument',
          params: {
            'docId': _i1.ParameterDescription(
              name: 'docId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i5.DocumentEndpoint)
                  .analyzeDocument(
                    session,
                    params['docId'],
                  ),
        ),
        'getDocumentsBySession': _i1.MethodConnector(
          name: 'getDocumentsBySession',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['document'] as _i5.DocumentEndpoint)
                  .getDocumentsBySession(
                    session,
                    params['sessionId'],
                  ),
        ),
      },
    );
    connectors['userImage'] = _i1.EndpointConnector(
      name: 'userImage',
      endpoint: endpoints['userImage']!,
      methodConnectors: {
        'updateUserImage': _i1.MethodConnector(
          name: 'updateUserImage',
          params: {
            'base64Content': _i1.ParameterDescription(
              name: 'base64Content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'mimeType': _i1.ParameterDescription(
              name: 'mimeType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userImage'] as _i6.UserImageEndpoint)
                  .updateUserImage(
                    session,
                    params['base64Content'],
                    params['mimeType'],
                  ),
        ),
        'getProfileImageUrl': _i1.MethodConnector(
          name: 'getProfileImageUrl',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userImage'] as _i6.UserImageEndpoint)
                  .getProfileImageUrl(session),
        ),
        'removeUserImage': _i1.MethodConnector(
          name: 'removeUserImage',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userImage'] as _i6.UserImageEndpoint)
                  .removeUserImage(session),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i10.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth'] = _i11.Endpoints()..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i12.Endpoints()
      ..initializeEndpoints(server);
  }
}
