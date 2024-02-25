import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double longitude;
  final double latitude;

  const Location({
    required this.longitude,
    required this.latitude,
  });

  @override
  List<Object?> get props => [longitude, latitude];
}
