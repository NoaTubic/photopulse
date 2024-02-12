import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photopulse/theme/app_colors.dart';

class AdminTabView extends HookWidget {
  final List<Widget> children;
  final List<Widget> tabs;

  const AdminTabView({
    super.key,
    required this.children,
    required this.tabs,
  }) : assert(children.length == tabs.length);

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: tabs.length);

    return Column(
      children: [
        TabBar(
          labelColor: AppColors.black,
          dividerColor: AppColors.black.withOpacity(0.2),
          indicatorColor: AppColors.black,
          controller: tabController,
          overlayColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.1)),
          tabs: tabs,
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: children,
          ),
        ),
      ],
    );
  }
}
