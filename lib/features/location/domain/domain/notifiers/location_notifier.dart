import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:photopulse/features/location/data/repositories/location_repository.dart';
import 'package:photopulse/features/location/domain/domain/notifiers/location_state.dart';
import 'package:q_architecture/q_architecture.dart';

final locationNotifierProvider =
    StateNotifierProvider<LocationNotifier, LocationState>(
  (ref) => LocationNotifier(
    ref.read(locationRepositoryProvider),
    ref,
  ),
);

class LocationNotifier extends SimpleStateNotifier<LocationState> {
  final LocationRepository _locationRepository;
  LocationNotifier(this._locationRepository, Ref ref)
      : super(ref, LocationState.initial());

  Future<bool> _init() async {
    state = state.copyWith(isLoading: true);
    final location = await _locationRepository.getLocation();
    bool isGranted = false;
    location.fold(
      (failure) {
        state = state.copyWith(
          isPermissionGranted: false,
          failure: failure,
          isLoading: false,
        );
        isGranted = false;
      },
      (location) {
        state = state.copyWith(
          isPermissionGranted: true,
          location: location,
          isLoading: false,
        );

        isGranted = true;
      },
    );
    state = state.copyWith(isInitialized: true);
    return isGranted;
  }

  Future<void> updateLocation(LatLng location) async {
    await debounce(duration: const Duration(milliseconds: 1500));
    state = state.copyWith(
      location: location,
      isInitialized: true,
    );
  }

  Future<bool> checkPermission() async {
    if (!state.isInitialized) {
      await _init();
    }
    return state.isPermissionGranted;
  }
}
