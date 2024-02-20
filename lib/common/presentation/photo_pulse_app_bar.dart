import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/display_text.dart';
import 'package:photopulse/theme/app_colors.dart';

class PhotoPulseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Color? titleColor;
  final Widget? leading;
  final Widget? centerAction;
  final List<Widget>? actions;
  final Alignment titleAlignment;
  final double leadingWidth;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final Function()? onTap;
  final bool titleOnly;
  final double? height;
  final Widget? flexibleSpace;

  const PhotoPulseAppBar({
    super.key,
    this.title,
    this.titleColor,
    this.leading,
    this.centerAction,
    this.actions,
    this.titleAlignment = Alignment.center,
    this.leadingWidth = 64,
    this.backgroundColor,
    this.bottom,
    this.onTap,
    this.titleOnly = false,
    this.height,
    this.flexibleSpace,
  });

  factory PhotoPulseAppBar.withBackNav({
    String title = '',
    required void Function() onTap,
    Color iconColor = Colors.black,
    Color? titleColor,
  }) =>
      PhotoPulseAppBar(
        title: title,
        titleColor: titleColor,
        titleAlignment: Alignment.topCenter,
        leading: GestureDetector(
          onTap: onTap,
          child: Icon(
            Icons.arrow_back_rounded,
            color: iconColor,
          ),
        ),
      );

  factory PhotoPulseAppBar.titleOnly(
    String title,
  ) =>
      PhotoPulseAppBar(
        title: title,
        titleOnly: true,
        titleAlignment: Alignment.topCenter,
        leadingWidth: AppSizes.smallSpacing,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        forceMaterialTransparency: true,
        backgroundColor: backgroundColor,
        flexibleSpace: flexibleSpace,
        toolbarHeight: height,
        title: centerAction ??
            Align(
              alignment: titleAlignment,
              child: DisplayText(
                title ?? '',
                color: titleColor ?? AppColors.black,
              ),
            ),
        bottom: bottom,
        leading: leading != null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.smallSpacing,
                ),
                child: leading,
              )
            : const SizedBox(),
        leadingWidth: leadingWidth,
        actions: actions ??
            [
              SizedBox(
                width: leadingWidth,
              ),
            ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
