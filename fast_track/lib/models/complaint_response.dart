import 'package:json_annotation/json_annotation.dart';
part 'complaint_response.g.dart';
@JsonSerializable()
class ComplaintResponse {
  final int id;
  final String title;
  final String description;
  final String date;
  final String status;
  final String location;
  final String category;
  final Map<String, dynamic> user;

  ComplaintResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.location,
    required this.category,
    required this.user,
  });
factory  ComplaintResponse.fromJson(Map<String, dynamic> json) => _$ComplaintResponseFromJson(json);
  
}
