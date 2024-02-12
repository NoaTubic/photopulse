import 'package:flutter/material.dart';
import 'package:photopulse/common/domain/router/pages.dart';
import 'package:photopulse/features/feed/presentation/pages/home_page.dart';
import 'package:photopulse/features/profile/presentation/pages/profile_page.dart';
import 'package:photopulse/features/upload_content/presentation/pages/upload_content_page.dart';
import 'package:photopulse/generated/l10n.dart';

enum BottomNavBarItem {
  home(
    icon: Icon(
      Icons.home_rounded,
      color: Colors.black,
    ),
    routeName: HomePage.routeName,
    snakeCaseTitle: Pages.home,
  ),

  uploadContent(
    icon: Icon(
      Icons.add_box_outlined,
      color: Colors.black,
    ),
    routeName: UploadContentPage.routeName,
    snakeCaseTitle: Pages.uploadContent,
  ),
  search(
    icon: Icon(
      Icons.search_rounded,
      color: Colors.black,
    ),
    routeName: Pages.searchPosts,
    snakeCaseTitle: Pages.searchPosts,
  ),
  profile(
    icon: Icon(
      Icons.person_rounded,
      color: Colors.black,
    ),
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
        return S.current.home_tab;
      case BottomNavBarItem.uploadContent:
        return S.current.upload_content_tab;
      case BottomNavBarItem.search:
        return S.current.search_tab;
      case BottomNavBarItem.profile:
        return S.current.profile_tab;
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
