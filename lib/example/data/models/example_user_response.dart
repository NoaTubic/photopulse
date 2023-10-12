import 'package:json_annotation/json_annotation.dart';

part 'example_user_response.g.dart';

@JsonSerializable()
class ExampleUserResponse {
  final String firstName;
  final String lastName;
  final DateTime birthday;
  final String gender;

  ExampleUserResponse(
    this.firstName,
    this.lastName,
    this.birthday,
    this.gender,
  );

  factory ExampleUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ExampleUserResponseFromJson(json);

  @override
  String toString() {
    return 'ExampleUserResponse { $firstName $lastName $birthday $gender }';
  }
}
