import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MapTileLayer extends StatelessWidget {
  const MapTileLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TileLayer(
      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
      subdomains: const ['a', 'b', 'c'],
    );
  }
}
