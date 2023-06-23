import 'package:json_annotation/json_annotation.dart';
part 'complaint.g.dart';
@JsonSerializable()
class Complaint {
  String? title;
  String? description;
  String? submissionDateTime;
  String? status;
  String? location;
  String? category;

  Complaint(
      {this.title,
      this.description,
      this.submissionDateTime,
      this.status,
      this.location,
      this.category});

factory Complaint.fromJson(Map<String, dynamic> json) => _$ComplaintFromJson(json);
Map<String, dynamic> toJson() => _$ComplaintToJson(this);

}
