import 'package:json_annotation/json_annotation.dart';
part 'response_list.g.dart';
@JsonSerializable()
class ResponseList {
  @JsonKey(name: "data")
  List<dynamic>? data;
  int? totalPages;
  int? totalItemsInPage;
  int? totalElements;

  ResponseList(
      {this.data, this.totalPages, this.totalItemsInPage, this.totalElements});

factory ResponseList.fromJson(Map<String, dynamic> json) => _$ResponseListFromJson(json);
Map<String, dynamic> toJson() => _$ResponseListToJson(this);

}
