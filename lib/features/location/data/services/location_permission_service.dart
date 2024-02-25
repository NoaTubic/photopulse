import 'package:either_dart/either.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/location/data/wrappers/geolocator_wrapper.dart';
import 'package:photopulse/features/location/domain/failures/location_permission_failure.dart';

final locationPermissionServiceProvider = Provider<LocationPermissionService>(
  (ref) => LocationPermissionServiceImpl(
    ref.read(geolocatorWrapperProvider),
  ),
);

abstract interface class LocationPermissionService {
  Future<Either<LocationPermissionFailure, void>> checkLocationPermission();
}

class LocationPermissionServiceImpl implements LocationPermissionService {
  final GeolocatorWrapper _gelocator;

  LocationPermissionServiceImpl(this._gelocator);

  @override
  Future<Either<LocationPermissionFailure, void>>
      checkLocationPermission() async {
    late LocationPermission permission;

    final serviceEnabled = await _gelocator.isLocationServiceEnabled;
    if (!serviceEnabled) {
      return Left(LocationPermissionFailure.disabled());
    }
    permission = await _gelocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Left(LocationPermissionFailure.permanatelyDenied());
    }

    if (permission == LocationPermission.denied) {
      permission = await _gelocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Left(LocationPermissionFailure.denied());
      }
    }
    return const Right(null);
  }
}
