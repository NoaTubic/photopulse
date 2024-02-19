import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/location/data/services/geocoding_service_impl.dart';
import 'package:photopulse/features/location/domain/domain/notifiers/location_list_state.dart';
import 'package:photopulse/features/location/domain/domain/notifiers/location_notifier.dart';
import 'package:photopulse/features/location/domain/entities/post_location.dart';
import 'package:q_architecture/q_architecture.dart';

final locationListNotifierProvider =
    StateNotifierProvider<LocationListNotifier, LocationListState>(
  (ref) => LocationListNotifier(
    ref.read(geocodingServiceProvider),
    ref,
  )..getPlacemarks(),
);

class LocationListNotifier extends SimpleStateNotifier<LocationListState> {
  final GeocodingService _geocodingService;
  LocationListNotifier(this._geocodingService, Ref ref)
      : super(ref, LocationListState.initial());

  void changeLocation(PostLocation location) =>
      state = state.copyWith(selectedLocation: location);

  Future<void> getPlacemarks() async {
    final location = ref.read(locationNotifierProvider).location;

    final result = await _geocodingService.getPlacemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );

    result.fold(
      (failure) => [],
      (placemarks) {
        state = state.copyWith(
          selectedLocation: PostLocation(
              name: placemarks.first.name!,
              latitude: location.latitude,
              longitude: location.longitude),
          locations: placemarks
              .map(
                (pm) => PostLocation(
                    name: pm.name!,
                    longitude: location.longitude,
                    latitude: location.latitude),
              )
              .toList(),
        );
      },
    );
  }
}
