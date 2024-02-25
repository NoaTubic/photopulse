import 'package:q_architecture/q_architecture.dart';

class LocationFailure extends Failure {
  const LocationFailure()
      : super(title: 'Could not fetch location. Please try again later.');
}
