// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordResetRequest _$PasswordResetRequestFromJson(
        Map<String, dynamic> json) =>
    PasswordResetRequest(
      msisdn: json['msisdn'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$PasswordResetRequestToJson(
        PasswordResetRequest instance) =>
    <String, dynamic>{
      'msisdn': instance.msisdn,
      'password': instance.password,
    };
