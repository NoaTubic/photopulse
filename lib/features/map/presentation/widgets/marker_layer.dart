import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:photopulse/theme/app_colors.dart';

class MapMarkerLayer extends StatelessWidget {
  const MapMarkerLayer({
    super.key,
    required this.initialLocation,
  });

  final LatLng initialLocation;

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
        Marker(
          point: initialLocation,
          child: Icon(
            Icons.location_pin,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}
