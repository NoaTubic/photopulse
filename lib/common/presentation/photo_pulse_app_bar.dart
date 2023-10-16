import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';

class PhotoPulseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
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
    Key? key,
    this.title,
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
  }) : super(key: key);

  factory PhotoPulseAppBar.withBackNav({
    String title = '',
    onTap,
  }) =>
      PhotoPulseAppBar(
        leadingWidth: AppSizes.xLargeSpacing,
        title: title,
        titleAlignment: Alignment.bottomLeft,
        leading: IconButton(
            onPressed: onTap, icon: const Icon(Icons.arrow_back_rounded)),
      );

  factory PhotoPulseAppBar.titleOnly(
    String title,
  ) =>
      PhotoPulseAppBar(
        title: title,
        titleOnly: true,
        titleAlignment: Alignment.topLeft,
        leadingWidth: AppSizes.smallSpacing,
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      flexibleSpace: flexibleSpace,
      toolbarHeight: height,
      title: centerAction ??
          Align(
            alignment: titleAlignment,
            child: Text(
              title ?? '',
            ),
          ),
      bottom: bottom,
      leadingWidth: leadingWidth,
      leading: titleOnly
          ? const SizedBox()
          : leading ??
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.normalSpacing,
                ),
                child: SizedBox(),
              ),
      actions: actions,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
