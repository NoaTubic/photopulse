import 'package:flutter/material.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/features/home/presentation/home_page.dart';
import 'package:photopulse/features/profile/presentation/pages/profile_page.dart';
import 'package:photopulse/features/upload_content/presentation/pages/upload_content_page.dart';

enum BottomNavBarItem {
  home(
    icon: Icon(Icons.home_rounded),
    routeName: HomePage.routeName,
    snakeCaseTitle: Pages.home,
  ),

  uploadContent(
    icon: Icon(Icons.add_box_outlined),
    routeName: UploadContentPage.routeName,
    snakeCaseTitle: Pages.uploadContent,
  ),
  profile(
    icon: Icon(Icons.person_rounded),
    routeName: ProfilePage.routeName,
    snakeCaseTitle: Pages.profile,
  );

  const BottomNavBarItem({
    required this.icon,
    required this.routeName,
    required this.snakeCaseTitle,
  });

  final Icon icon;
  final String routeName;
  final String snakeCaseTitle;

  String get title {
    switch (this) {
      case BottomNavBarItem.home:
        return 'Home';
      case BottomNavBarItem.uploadContent:
        return 'Upload content';
      case BottomNavBarItem.profile:
        return 'Profile';
      default:
        return '';
    }
  }

  static List<BottomNavBarItem> getValues() {
    return values;
  }

  static int getIndexForLocation({
    String? location,
  }) =>
      values
          .toList()
          .indexed
          .firstWhere(
            (element) => location?.startsWith(element.$2.routeName) == true,
            orElse: () => (BottomNavBarItem.home.index, BottomNavBarItem.home),
          )
          .$1;
}
