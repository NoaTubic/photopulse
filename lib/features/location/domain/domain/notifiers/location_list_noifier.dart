import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/location/data/services/geocoding_service_impl.dart';
import 'package:photopulse/features/location/domain/domain/notifiers/location_notifier.dart';
import 'package:photopulse/features/location/domain/entities/post_location.dart';
import 'package:q_architecture/q_architecture.dart';

class LocationListNotifier extends SimpleStateNotifier<List<PostLocation>> {
  final GeocodingService _geocodingService;
  LocationListNotifier(this._geocodingService, Ref ref) : super(ref, []);

  Future<void> updateLocation() async {
    final location = ref.read(locationNotifierProvider).location;

    final result = await _geocodingService.getPlacemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );

    result.fold(
      (failure) => [],
      (placemarks) {
        state = placemarks
            .map(
              (pm) => PostLocation(
                  name: pm.name!,
                  longitude: location.longitude,
                  latitude: location.latitude),
            )
            .toList();
      },
    );
  }
}
