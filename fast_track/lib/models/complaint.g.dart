// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complaint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Complaint _$ComplaintFromJson(Map<String, dynamic> json) => Complaint(
      title: json['title'] as String,
      description: json['description'] as String,
      submissionDateTime: json['submissionDateTime'] as String,
      status: json['status'] as String,
      location: json['location'] as String,
      category: json['category'] as String,
    );

Map<String, dynamic> _$ComplaintToJson(Complaint instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'submissionDateTime': instance.submissionDateTime,
      'status': instance.status,
      'location': instance.location,
      'category': instance.category,
    };
