import 'package:json_annotation/json_annotation.dart';
part 'feedback.g.dart';

@JsonSerializable()
class FeedbackRequest {
  
  final String feedbackType;
  final String description;
  final String submissionDateTime;
  final String status;


  FeedbackRequest( 
      {
      required this.feedbackType,
      required this.description,
      required this.submissionDateTime,
      required this.status
      });

factory FeedbackRequest.fromJson(Map<String, dynamic> json) => _$FeedbackRequestFromJson(json);
Map<String, dynamic> toJson() => _$FeedbackRequestToJson(this);
}