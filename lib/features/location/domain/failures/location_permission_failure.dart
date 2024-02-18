import 'package:q_architecture/q_architecture.dart';

sealed class LocationPermissionFailure extends Failure {
  const LocationPermissionFailure({required super.title});

  factory LocationPermissionFailure.disabled() =>
      const DisabledLocationPermissionFailure();
  factory LocationPermissionFailure.denied() =>
      const LocationPermissionDeniedFailure();
  factory LocationPermissionFailure.permanatelyDenied() =>
      const LocationPermissionPermanentlyDeniedFailure();
}

class DisabledLocationPermissionFailure extends LocationPermissionFailure {
  const DisabledLocationPermissionFailure()
      : super(
            title:
                'Location services are disabled. Please enable the services');
}

class LocationPermissionDeniedFailure extends LocationPermissionFailure {
  const LocationPermissionDeniedFailure()
      : super(title: 'Location permissions are denied');
}

class LocationPermissionPermanentlyDeniedFailure
    extends LocationPermissionFailure {
  const LocationPermissionPermanentlyDeniedFailure()
      : super(
            title:
                'Location permissions are permanently denied, we cannot request permissions.');
}
