// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComplaintResponse _$ComplaintResponseFromJson(Map<String, dynamic> json) =>
    ComplaintResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
      location: json['location'] as String,
      category: json['category'] as String,
      user: json['user'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ComplaintResponseToJson(ComplaintResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
      'status': instance.status,
      'location': instance.location,
      'category': instance.category,
      'user': instance.user,
    };
