// ignore_for_file: control_flow_in_finally
import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/location/data/wrappers/geolocator_wrapper.dart';
import 'package:photopulse/features/location/domain/entities/location.dart';
import 'package:photopulse/features/location/domain/failures/location_failure.dart';
import 'package:q_architecture/q_architecture.dart';

final locationServiceProvider = Provider<LocationService>(
  (ref) => LocationServiceImpl(
    ref.read(geolocatorWrapperProvider),
  ),
);

abstract interface class LocationService {
  EitherFailureOr<Location> getLocation();
}

class LocationServiceImpl implements LocationService {
  final GeolocatorWrapper _geolocator;

  LocationServiceImpl(
    this._geolocator,
  );

  @override
  EitherFailureOr<Location> getLocation() async {
    try {
      final position = await _geolocator.currentPosition;
      final location =
          Location(longitude: position.longitude, latitude: position.latitude);
      return Right(location);
    } on TimeoutException {
      return const Left(LocationFailure());
    } catch (e) {
      return const Left(LocationFailure());
    }
  }
}
