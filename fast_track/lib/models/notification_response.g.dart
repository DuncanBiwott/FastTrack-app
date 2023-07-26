// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      user: json['user'] as Map<String, dynamic>,
      id: json['id'] as int,
      message: json['message'] as String,
      sendingDateTime: json['sendingDateTime'] as String,
      readStatus: json['readStatus'] as String,
    );

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'sendingDateTime': instance.sendingDateTime,
      'readStatus': instance.readStatus,
      'user': instance.user,
    };
