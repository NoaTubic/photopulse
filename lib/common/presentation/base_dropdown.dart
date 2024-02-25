import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';
import 'package:photopulse/theme/app_colors.dart';

class BaseDropdown<T> extends StatelessWidget {
  const BaseDropdown({
    super.key,
    required this.onChanged,
    required this.values,
    required this.hint,
  });

  final Function(T? value) onChanged;
  final List<T> values;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.5,
      icon: const Icon(Icons.keyboard_arrow_down_rounded),
      items: values
          .map((e) => DropdownMenuItem<T>(
                value: e,
                child: BodyText(e.toString()),
              ))
          .toList(),
      onChanged: onChanged,
      hint: BodyText(
        hint,
        color: AppColors.black,
      ),
      selectedItemBuilder: (context) => values
          .map((e) => DropdownMenuItem<T>(
                value: e,
                child: BodyText(
                  e.toString(),
                ),
              ))
          .toList(),
    );
  }
}
