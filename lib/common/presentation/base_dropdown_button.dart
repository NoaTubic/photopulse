import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/text.dart';
import 'package:photopulse/theme/app_colors.dart';

class BaseDropdownButton extends StatelessWidget {
  const BaseDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    required this.hint,
    required this.customItemsHeights,
  });

  final List<DropdownMenuItem<String>>? items;
  final List<double>? customItemsHeights;
  final void Function(String?)? onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        onChanged: onChanged,
        items: items,
        customItemsHeights: customItemsHeights,
        hint: Padding(
          padding: const EdgeInsets.only(right: AppSizes.compactSpacing),
          child: BodyText(hint),
        ),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        dropdownElevation: 3,
        buttonHeight: 20,
        dropdownWidth: 160,
        dropdownPadding: EdgeInsets.zero,
        alignment: AlignmentDirectional.centerEnd,
        dropdownDirection: DropdownDirection.left,
        dropdownDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppSizes.normalCircularRadius,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: avoid-returning-widgets
List<DropdownMenuItem<String>> addDividersAfterItems(
  List<String> items,
  BuildContext context,
) {
  final List<DropdownMenuItem<String>> menuItems = [];
  for (final item in items) {
    menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: BodyText(item),
        ),
        if (item != items.last)
          DropdownMenuItem<String>(
            enabled: false,
            child: Divider(
              color: AppColors.black.withOpacity(0.2),
              thickness: 1,
            ),
          ),
      ],
    );
  }
  return menuItems;
}

List<double> getCustomItemsHeights(List<String> items) {
  final List<double> itemsHeights = [];
  for (var i = 0; i < (items.length * 2) - 1; i++) {
    if (i.isEven) {
      itemsHeights.add(40);
    }
    if (i.isOdd) {
      itemsHeights.add(1);
    }
  }
  return itemsHeights;
}
