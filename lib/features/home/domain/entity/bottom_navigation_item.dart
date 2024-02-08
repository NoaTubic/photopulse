// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:photopulse/common/domain/router/pages.dart';

enum BottomNavigationItem {
  home(
    icon: Icons.home_rounded,
    routeName: Pages.home,
  ),
  uploadContent(icon: Icons.add_box_rounded, routeName: Pages.uploadContent),
  profile(icon: Icons.person_rounded, routeName: Pages.profile);

  final IconData icon;
  final String routeName;

  const BottomNavigationItem({required this.icon, required this.routeName});

  String get title => switch (this) {
        home => 'Home',
        uploadContent => 'Upload content',
        profile => 'Profile',
      };

  static int getIndexForLocation(String? location) =>
      BottomNavigationItem.values
          .firstWhere(
            (element) => location?.startsWith(element.routeName) == true,
            orElse: () => BottomNavigationItem.home,
          )
          .index;
}
