import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';

class NavBarContentWrapper extends StatelessWidget {
  const NavBarContentWrapper({super.key, required this.content});

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
            maxWidth: AppSizes.navigationRailBreakingPoint),
        child: content,
      ),
    );
  }
}
