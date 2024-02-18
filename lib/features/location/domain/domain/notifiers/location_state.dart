import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:q_architecture/q_architecture.dart';

part 'location_state.freezed.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    required bool isPermissionGranted,
    required LatLng location,
    required bool isLoading,
    required bool isInitialized,
    Failure? failure,
  }) = _LocationState;

  factory LocationState.initial() => const LocationState(
        isPermissionGranted: false,
        location: LatLng(0, 0),
        isLoading: true,
        isInitialized: false,
      );
}
