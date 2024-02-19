import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/features/location/domain/entities/post_location.dart';
import 'package:photopulse/features/map/presentation/widgets/directions_button.dart';
import 'package:photopulse/features/map/presentation/widgets/marker_layer.dart';
import 'package:photopulse/features/map/presentation/widgets/tile_layer.dart';

class MapPage extends StatelessWidget {
  static const String routeName = Pages.map;
  final PostLocation location;

  const MapPage({
    super.key,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final initialLocation = LatLng(location.latitude, location.longitude);
    return PhotoPulseScaffold(
      padding: EdgeInsets.zero,
      appBar: AppBar(
        title: Text(location.name),
      ),
      body: Stack(
        children: [
          IgnorePointer(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: initialLocation,
              ),
              children: [
                const MapTileLayer(),
                MapMarkerLayer(initialLocation: initialLocation),
              ],
            ),
          ),
          DirectionsButton(
            location: initialLocation,
          ),
        ],
      ),
    );
  }
}
