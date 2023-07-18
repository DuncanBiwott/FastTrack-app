import 'package:json_annotation/json_annotation.dart';
part 'event_response.g.dart';
@JsonSerializable()
class EventResponse {

  int? id;
  String? title;
  String? description;
  String? eventDateTime;
  String? location;
  String? organizer;
  String? contactInformation;
  String? imageUrl;
  String? category;

  EventResponse(
      {this.id,
      this.title,
      this.description,
      this.eventDateTime,
      this.location,
      this.organizer,
      this.contactInformation,
      this.imageUrl,
      this.category});

factory  EventResponse.fromJson(Map<String, dynamic> json) => _$EventResponseFromJson(json);
  
}
