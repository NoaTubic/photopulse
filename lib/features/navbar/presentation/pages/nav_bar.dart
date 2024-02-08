import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/domain/providers/base_router_provider.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/build_context_extensions.dart';
import 'package:photopulse/common/presentation/image_assets.dart';
import 'package:photopulse/common/presentation/text/display_text.dart';
import 'package:photopulse/features/auth/domain/notifiers/user_notifier.dart';
import 'package:photopulse/features/navbar/domain/notifiers/nav_bar_visibility_provider.dart';
import 'package:photopulse/features/navbar/presentation/widgets/bottom_nav_bar_item.dart';
import 'package:photopulse/features/navbar/presentation/widgets/navigation_rail_divider.dart';
import 'package:photopulse/features/navbar/presentation/widgets/navigation_rail_item.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/theme.dart';

class NavBar extends ConsumerWidget {
  static const routeName = '/';

  final StatefulNavigationShell navigationShell;

  const NavBar({super.key, required this.navigationShell});

  void _onDestinationSelected({
    required int index,
  }) {
    final newIndex = BottomNavBarItem.getValues()[index].index;
    navigationShell.goBranch(
      newIndex,
      initialLocation: newIndex == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bottomNavBarItems = BottomNavBarItem.getValues();
    final selectedIndex = BottomNavBarItem.getIndexForLocation(
      location: ref.read(baseRouterProvider).currentLocationUri.path,
    );
    return Scaffold(
      body: Row(
        children: [
          if (screenWidth >= AppSizes.navigationRailBreakingPoint)
            NavigationRail(
              minWidth: AppSizes.navigationRailWidth,
              leading: Padding(
                padding: const EdgeInsets.only(
                  left: AppSizes.navigationRailWidth / 4,
                  bottom: AppSizes.largeSpacing,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.logo,
                      height: context.isLargerThanMobile
                          ? AppSizes.appLogoWeb
                          : AppSizes.appLogo,
                    ),
                    const Gap(
                      AppSizes.smallSpacing,
                    ),
                    DisplayText(
                      S.current.photo_pulse,
                      color: AppColors.black,
                      fontSize: context.isLargerThanMobile
                          ? FontSizes.s30
                          : FontSizes.s24,
                      fontFamily: 'Cocogoose Pro',
                    ),
                  ],
                ),
              ),
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) => _onDestinationSelected(
                index: index,
              ),
              labelType: NavigationRailLabelType.none,
              destinations: bottomNavBarItems
                  .map(
                    (tab) => NavigationRailDestination(
                      icon: NavigationRailItem(
                        icon: tab.icon,
                        title: tab.title,
                        isSelected: false,
                      ),
                      selectedIcon: NavigationRailItem(
                        icon: tab.icon,
                        title: tab.title,
                        isSelected: true,
                      ),
                      label: Text(tab.title),
                    ),
                  )
                  .toList(),
            ),
          // const NavigationRailDivider(),
          Expanded(child: navigationShell),
        ],
      ),
      bottomNavigationBar: screenWidth < AppSizes.navigationRailBreakingPoint &&
              !(ref.watch(userProvider)?.isFirstLogin ?? true) &&
              ref.watch(navBarVisibilityProvider)
          ? AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: screenWidth < AppSizes.navigationRailBreakingPoint &&
                      !(ref.watch(userProvider)?.isFirstLogin ?? true) &&
                      ref.watch(navBarVisibilityProvider)
                  ? 1
                  : 0,
              child: NavigationBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                selectedIndex: selectedIndex,
                indicatorColor: AppColors.black.withOpacity(0.05),
                onDestinationSelected: (index) => _onDestinationSelected(
                  index: index,
                ),
                destinations: bottomNavBarItems
                    .map(
                      (tab) => NavigationDestination(
                        icon: tab.icon,
                        label: tab.title,
                      ),
                    )
                    .toList(),
              ),
            )
          : null,
    );
  }
}
