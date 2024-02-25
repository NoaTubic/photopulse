// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLocation _$PostLocationFromJson(Map<String, dynamic> json) => PostLocation(
      name: json['name'] as String,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
    );

Map<String, dynamic> _$PostLocationToJson(PostLocation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
