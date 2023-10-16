// ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DirectoriesPage extends ConsumerWidget {
  static const routeName = '/directories';
  static String pathPattern(int level) => ':directoryName$level';

  const DirectoriesPage({
    super.key,
    this.directoryName,
    this.canGoDeeper = true,
  });

  final String? directoryName;
  final bool canGoDeeper;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: const [
        // if (directoryName != null) ...[
        //   TextButton(
        //     onPressed: ref.pop,
        //     child: Text(
        //       'Go back',
        //       style: context.appTextStyles.regular,
        //     ),
        //   ),
        //   const SizedBox(height: AppSizes.normalSpacing),
        // ],
        // Text(
        //   'Directories: $directoryName',
        //   style: context.appTextStyles.bold,
        //   textAlign: TextAlign.center,
        // ),
        // if (canGoDeeper) ...[
        //   const SizedBox(height: AppSizes.normalSpacing),
        //   TextButton(
        //     onPressed: () => ref.pushNamed(ref.getRouteNameFromCurrentLocation(
        //       '/${Random().nextInt(100)}',
        //     )),
        //     child: Text(
        //       'Open child directory',
        //       style: context.appTextStyles.regular,
        //     ),
        //   ),
        // ],
      ],
    );
  }
}
