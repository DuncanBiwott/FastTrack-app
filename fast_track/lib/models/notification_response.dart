import 'package:json_annotation/json_annotation.dart';
part 'notification_response.g.dart';
@JsonSerializable()
class NotificationResponse {
  final int id;
	final String message;
	final String sendingDateTime;
	final String readStatus;
  final Map<String, dynamic> user;

  NotificationResponse( {
    required this.user,
    required this.id,
    required this.message,
    required this.sendingDateTime,
    required this.readStatus,
  });
factory NotificationResponse.fromJson(Map<String, dynamic> json) => _$NotificationResponseFromJson(json);

}