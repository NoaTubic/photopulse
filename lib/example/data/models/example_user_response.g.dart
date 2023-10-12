// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExampleUserResponse _$ExampleUserResponseFromJson(Map<String, dynamic> json) =>
    ExampleUserResponse(
      json['firstName'] as String,
      json['lastName'] as String,
      DateTime.parse(json['birthday'] as String),
      json['gender'] as String,
    );

Map<String, dynamic> _$ExampleUserResponseToJson(
        ExampleUserResponse instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'birthday': instance.birthday.toIso8601String(),
      'gender': instance.gender,
    };
