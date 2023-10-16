import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/gradient_background.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';

class PhotoPulseScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? bottomNavigationBar;
  final EdgeInsets padding;
  final bool resizeToAvoidBottomInset;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool gradientBackground;

  const PhotoPulseScaffold({
    super.key,
    this.body,
    this.bottomNavigationBar,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSizes.bodyPaddingHorizontal,
    ),
    this.resizeToAvoidBottomInset = false,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.gradientBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar ?? PhotoPulseAppBar.titleOnly(''),
      body: gradientBackground
          ? GradientBackground(
              child: SafeArea(
                child: Padding(
                  padding: padding,
                  child: body,
                ),
              ),
            )
          : SafeArea(
              child: Padding(
                padding: padding,
                child: body,
              ),
            ),
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation ??
          FloatingActionButtonLocation.centerFloat,
    );
  }
}
