// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackRequest _$FeedbackRequestFromJson(Map<String, dynamic> json) =>
    FeedbackRequest(
      feedbackType: json['feedbackType'] as String,
      description: json['description'] as String,
      submissionDateTime: json['submissionDateTime'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$FeedbackRequestToJson(FeedbackRequest instance) =>
    <String, dynamic>{
      'feedbackType': instance.feedbackType,
      'description': instance.description,
      'submissionDateTime': instance.submissionDateTime,
      'status': instance.status,
    };
