import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapLauncher {
  final LatLng latLng;
  MapLauncher({required this.latLng});

  void launch() => MapsLauncher.launchCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
}
