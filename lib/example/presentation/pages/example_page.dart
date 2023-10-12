// ignore_for_file: always_use_package_imports

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_state_notifier.dart';

import '../../../common/domain/router/navigation_extensions.dart';
import '../../../common/presentation/app_sizes.dart';
import '../../../common/presentation/build_context_extensions.dart';
import '../../../common/utils/q_logger.dart';
import '../../domain/notifiers/example_filters/example_filters_provider.dart';
import '../../domain/notifiers/example_notifier/example_state_notifier.dart';
import 'example_simple_page.dart';
import 'form_example_page.dart';
import 'pagination_example_page.dart';
import 'pagination_stream_example_page.dart';

class ExamplePage extends ConsumerWidget {
  static const routeName = '/example';

  const ExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(exampleNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Example page')),
      body: ListView(
        children: [
          const SizedBox(height: AppSizes.normalSpacing),
          Text(
            switch (state) {
              BaseData(data: final sentence) => sentence,
              BaseLoading() => 'Loading',
              BaseInitial() => 'Initial',
              BaseError(failure: final failure) => failure.toString(),
            },
            style: context.appTextStyles.regular
                ?.copyWith(color: context.appColors.secondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: ref
                .read(exampleNotifierProvider.notifier)
                .getSomeStringFullExample,
            child: Text(
              'Get string',
              style: context.appTextStyles.bold,
            ),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: ref
                .read(exampleNotifierProvider.notifier)
                .getSomeStringGlobalLoading,
            child: Text(
              'Global loading example',
              style: context.appTextStyles.bold,
            ),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: ref
                .read(exampleNotifierProvider.notifier)
                .getSomeStringsStreamed,
            child: Text(
              'Cache + Network loading example',
              style: context.appTextStyles.bold,
            ),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () => ref
                .read(exampleFiltersProvider.notifier)
                .update((_) => 'Random ${Random().nextInt(100)}'),
            child: Text(
              'Update filters (to trigger reload of data)',
              style: context.appTextStyles.bold,
            ),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () => QLogger.showLogger(context),
            child: Text('Show log', style: context.appTextStyles.bold),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () => ref.pushNamed(
              ref.getRouteNameFromCurrentLocation(ExampleSimplePage.routeName),
            ),
            child:
                Text('Go to example simple', style: context.appTextStyles.bold),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () => ref.pushNamed(
              ref.getRouteNameFromCurrentLocation(FormExamplePage.routeName),
            ),
            child:
                Text('Go to form example', style: context.appTextStyles.bold),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () => ref.pushNamed(
              ref.getRouteNameFromCurrentLocation(
                PaginationExamplePage.routeName,
              ),
            ),
            child: Text('Go to pagination', style: context.appTextStyles.bold),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () => ref.pushNamed(
              ref.getRouteNameFromCurrentLocation(
                PaginationStreamExamplePage.routeName,
              ),
            ),
            child: Text(
              'Go to stream pagination',
              style: context.appTextStyles.bold,
            ),
          ),
        ],
      ),
    );
  }
}
