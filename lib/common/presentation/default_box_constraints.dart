import 'package:flutter/widgets.dart';
import 'package:responsive_framework/responsive_framework.dart';

BoxConstraints getDefaultBoxConstraints(
  BuildContext context, {
  double value = 550.0,
}) =>
    BoxConstraints(
      maxWidth: ResponsiveValue(
        context,
        defaultValue: double.infinity,
        conditionalValues: [
          Condition.largerThan(
            name: MOBILE,
            value: value,
          ),
        ],
      ).value!,
    );
