import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

@sealed
abstract class AuthResponse {}

@freezed
class AuthSuccess extends AuthResponse with _$AuthSuccess {
  factory AuthSuccess({
    required String userId,
    required bool mfa,
    bool? sms,
    String? ticket,
    String? token,
    bool? backup,
    bool? totp,
    dynamic webauthn,
  }) = _AuthSuccess;

  factory AuthSuccess.fromJson(Map<String, dynamic> json) =>
      _$AuthSuccessFromJson(json);
}

@freezed
class CaptchaResponse extends AuthResponse with _$CaptchaResponse {
  factory CaptchaResponse({
    required List<dynamic> captchaKey,
    required String captchaSitekey,
    required String captchaService,
  }) = _CaptchaResponse;

  factory CaptchaResponse.fromJson(Map<String, dynamic> json) =>
      _$CaptchaResponseFromJson(json);
}
