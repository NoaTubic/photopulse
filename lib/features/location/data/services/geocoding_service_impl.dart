import 'package:either_dart/either.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/location/domain/failures/geolocation_failure.dart';
import 'package:q_architecture/q_architecture.dart';

final geocodingServiceProvider = Provider<GeocodingService>(
  (ref) => GeocodingServiceImpl(),
);

abstract interface class GeocodingService {
  EitherFailureOr<List<Placemark>> getPlacemarkFromCoordinates(
      double latitude, double longitude);
}

class GeocodingServiceImpl implements GeocodingService {
  @override
  EitherFailureOr<List<Placemark>> getPlacemarkFromCoordinates(
      double latitude, double longitude) async {
    try {
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      return Right(placemarks);
    } catch (e) {
      return Left(
        GeolocationFailure(
          title: e.toString(),
        ),
      );
    }
  }
}
