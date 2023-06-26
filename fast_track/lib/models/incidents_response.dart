import 'package:json_annotation/json_annotation.dart';
part 'incidents_response.g.dart';
@JsonSerializable()
class IncidentResponse {
  final int id;
	final String title;
	final String description;
	final String dateTime;
	final String location;
	final String type;
	final String? downloadUrl;
	final List<String>? downloadUrls;
	final String status;
  final Map<String, dynamic> user;

  IncidentResponse( {
    required this.user,
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.dateTime,
    required this.type,
     this.downloadUrl,
    required this.status,
     this.downloadUrls,
  });
factory IncidentResponse.fromJson(Map<String, dynamic> json) => _$IncidentResponseFromJson(json);

}
