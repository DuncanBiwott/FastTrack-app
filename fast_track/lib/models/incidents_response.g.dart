// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'incidents_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncidentResponse _$IncidentResponseFromJson(Map<String, dynamic> json) =>
    IncidentResponse(
      user: json['user'] as Map<String, dynamic>,
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      location: json['location'] as String,
      dateTime: json['dateTime'] as String,
      type: json['type'] as String,
      downloadUrl: json['downloadUrl'] as String?,
      status: json['status'] as String,
      downloadUrls: (json['downloadUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$IncidentResponseToJson(IncidentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dateTime': instance.dateTime,
      'location': instance.location,
      'type': instance.type,
      'downloadUrl': instance.downloadUrl,
      'downloadUrls': instance.downloadUrls,
      'status': instance.status,
      'user': instance.user,
    };
