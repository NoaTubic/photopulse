import 'package:flutter/material.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';

class UploadContentPage extends StatelessWidget {
  static const routeName = Pages.uploadContent;
  const UploadContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PhotoPulseScaffold();
  }
}
