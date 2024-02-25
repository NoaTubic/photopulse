import 'package:json_annotation/json_annotation.dart';

part 'post_location.g.dart';

@JsonSerializable()
class PostLocation {
  final String name;
  final double longitude;
  final double latitude;

  PostLocation({
    required this.name,
    required this.longitude,
    required this.latitude,
  });

  @override
  String toString() {
    return name;
  }

  factory PostLocation.fromJson(Map<String, dynamic> json) =>
      _$PostLocationFromJson(json);

  Map<String, dynamic> toJson() => _$PostLocationToJson(this);
}
