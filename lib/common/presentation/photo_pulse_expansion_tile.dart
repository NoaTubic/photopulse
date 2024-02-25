import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/theme/app_colors.dart';

class PhotoPulseExpansionTile extends StatefulWidget {
  final String title;
  final IconData? leadingIcon;
  final List<Widget> children;
  final EdgeInsets? tilePadding;
  final bool showDivider;

  const PhotoPulseExpansionTile({
    required this.title,
    required this.children,
    this.leadingIcon,
    this.tilePadding,
    this.showDivider = true,
    super.key,
  });

  @override
  State<PhotoPulseExpansionTile> createState() =>
      _PhotoPulseExpansionTileState();
}

class _PhotoPulseExpansionTileState extends State<PhotoPulseExpansionTile> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppSizes.normalCircularBorderRadius,
        border: Border.all(
          color: AppColors.black.withOpacity(0.7),
        ),
      ),
      child: ClipRRect(
        borderRadius: AppSizes.normalCircularBorderRadius,
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            shape: const RoundedRectangleBorder(
              borderRadius: AppSizes.normalCircularBorderRadius,
            ),
            collapsedBackgroundColor: AppColors.white,
            backgroundColor: AppColors.white,
            leading: Icon(
              widget.leadingIcon,
              color: AppColors.black,
            ),
            tilePadding: widget.tilePadding,
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            trailing: _customTileExpanded
                ? const Icon(Icons.keyboard_arrow_up_rounded)
                : const Icon(Icons.keyboard_arrow_down_rounded),
            title: BodyText(
              widget.title,
              isBold: true,
            ),
            children: widget.children,
            onExpansionChanged: (bool expanded) {
              setState(
                () {
                  _customTileExpanded = expanded;
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
