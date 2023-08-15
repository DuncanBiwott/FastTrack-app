import 'package:json_annotation/json_annotation.dart';
part 'recommendation_response.g.dart';
@JsonSerializable()
class RecommendationResponse {
  final int id;
	final String title;
	final String description;
	final String submissionDateTime;
	final String location;
	final String category;
  final Map<String, dynamic> user;

  RecommendationResponse(
      {required this.id,
      required this.title,
      required this.description,
      required this.submissionDateTime,
      required this.location,
      required this.category,
      required this.user});



factory RecommendationResponse.fromJson(Map<String, dynamic> json) => _$RecommendationResponseFromJson(json);

}
