import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photopulse/features/location/domain/entities/post_location.dart';

part 'location_list_state.freezed.dart';

@freezed
class LocationListState with _$LocationListState {
  const factory LocationListState({
    PostLocation? selectedLocation,
    required List<PostLocation> locations,
  }) = _LocationListState;

  factory LocationListState.initial() => const LocationListState(locations: []);
}
