import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final geolocatorWrapperProvider =
    Provider<GeolocatorWrapper>((_) => GeolocatorWrapper());

class GeolocatorWrapper {
  Future<Position> get currentPosition => Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

  Future<bool> get isLocationServiceEnabled =>
      Geolocator.isLocationServiceEnabled();

  Future<LocationPermission> requestPermission() =>
      Geolocator.requestPermission();

  Future<LocationPermission> checkPermission() => Geolocator.checkPermission();
}
