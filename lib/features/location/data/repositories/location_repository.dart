import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:photopulse/features/location/data/services/location_permission_service.dart';
import 'package:photopulse/features/location/data/services/location_service.dart';
import 'package:photopulse/features/location/domain/failures/location_failure.dart';
import 'package:q_architecture/q_architecture.dart';

final locationRepositoryProvider = Provider<LocationRepository>(
  (ref) => LocationRepositoryImpl(
    ref.read(locationPermissionServiceProvider),
    ref.read(locationServiceProvider),
  ),
);

abstract class LocationRepository {
  EitherFailureOr<LatLng> getLocation();
}

class LocationRepositoryImpl implements LocationRepository {
  final LocationPermissionService _locationPermissionService;
  final LocationService _locationService;

  LocationRepositoryImpl(
    this._locationPermissionService,
    this._locationService,
  );

  @override
  EitherFailureOr<LatLng> getLocation() async {
    try {
      final isPermissionGranted =
          await _locationPermissionService.checkLocationPermission();

      if (isPermissionGranted.isLeft) return Left(isPermissionGranted.left);

      final currentLocation = await _locationService.getLocation();

      return currentLocation.fold(
        (failure) => Left(failure),
        (location) => Right(
          LatLng(location.latitude, location.longitude),
        ),
      );
    } catch (_) {
      return const Left(LocationFailure());
    }
  }
}
