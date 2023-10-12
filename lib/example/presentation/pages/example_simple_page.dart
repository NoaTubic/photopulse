// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/presentation/app_sizes.dart';
import '../../../common/presentation/build_context_extensions.dart';
import '../../domain/notifiers/example_simple_notifier/example_simple_state.dart';
import '../../domain/notifiers/example_simple_notifier/example_simple_state_notifier.dart';

class ExampleSimplePage extends ConsumerStatefulWidget {
  static const routeName = '/example-simple-page';

  const ExampleSimplePage({super.key});

  @override
  ConsumerState<ExampleSimplePage> createState() => _ExampleSimplePageState();
}

class _ExampleSimplePageState extends ConsumerState<ExampleSimplePage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(exampleSimpleStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example simple page'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: AppSizes.normalSpacing),
          Text(
            switch (state) {
              ExampleSimpleStateInitial() => 'Initial',
              ExampleSimpleStateEmpty() => 'Empty',
              ExampleSimpleStateFetching() => 'Fetching',
              ExampleSimpleStateSuccess(data: final string) => string,
              ExampleSimpleStateError(failure: final failure) => failure.title,
            },
            textAlign: TextAlign.center,
            style: context.appTextStyles.regular,
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: () {
              ref
                  .read(exampleSimpleStateNotifierProvider.notifier)
                  .getSomeStringSimpleExample();
              ref
                  .read(exampleSimpleStateNotifierProvider.notifier)
                  .getSomeStringSimpleExample();
            },
            child: Text(
              'Simple state example with debounce',
              style: context.appTextStyles.bold,
            ),
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          TextButton(
            onPressed: ref
                .read(exampleSimpleStateNotifierProvider.notifier)
                .getSomeStringSimpleExampleGlobalLoading,
            child: Text(
              'Global loading example',
              style: context.appTextStyles.bold,
            ),
          ),
        ],
      ),
    );
  }
}
