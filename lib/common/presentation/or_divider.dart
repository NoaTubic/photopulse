import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/text/body_text.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.mediumSpacing),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              indent: AppSizes.tinySpacing,
              endIndent: AppSizes.compactSpacing,
              thickness: AppSizes.tinySpacing,
              height: 2,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          const BodyText('OR'),
          Expanded(
            child: Divider(
              indent: AppSizes.tinySpacing,
              endIndent: AppSizes.compactSpacing,
              thickness: AppSizes.tinySpacing,
              height: 2,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
