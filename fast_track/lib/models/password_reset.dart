import 'package:json_annotation/json_annotation.dart';
part 'password_reset.g.dart';
@JsonSerializable()
class PasswordResetRequest {
 final String msisdn;
 final  String password;

  PasswordResetRequest({required this.msisdn, required this.password});

factory PasswordResetRequest.fromJson(Map<String, dynamic> json) => _$PasswordResetRequestFromJson(json);
Map<String, dynamic> toJson() => _$PasswordResetRequestToJson(this);
}