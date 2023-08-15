// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationResponse _$RecommendationResponseFromJson(
        Map<String, dynamic> json) =>
    RecommendationResponse(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      submissionDateTime: json['submissionDateTime'] as String,
      location: json['location'] as String,
      category: json['category'] as String,
      user: json['user'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RecommendationResponseToJson(
        RecommendationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'submissionDateTime': instance.submissionDateTime,
      'location': instance.location,
      'category': instance.category,
      'user': instance.user,
    };
