import 'package:json_annotation/json_annotation.dart';
part 'register_request.g.dart';

@JsonSerializable()
class UserRequest {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserRequest( 
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});

factory UserRequest.fromJson(Map<String, dynamic> json) => _$UserRequestFromJson(json);
Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}