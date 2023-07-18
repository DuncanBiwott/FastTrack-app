// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResponse _$EventResponseFromJson(Map<String, dynamic> json) =>
    EventResponse(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      eventDateTime: json['eventDateTime'] as String?,
      location: json['location'] as String?,
      organizer: json['organizer'] as String?,
      contactInformation: json['contactInformation'] as String?,
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$EventResponseToJson(EventResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'eventDateTime': instance.eventDateTime,
      'location': instance.location,
      'organizer': instance.organizer,
      'contactInformation': instance.contactInformation,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
    };
