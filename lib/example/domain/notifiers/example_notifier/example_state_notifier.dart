// ignore_for_file: always_use_package_imports

import 'package:q_architecture/base_state_notifier.dart';
import 'package:q_architecture/q_architecture.dart';

import '../../../data/repositories/example_repository.dart';
import '../example_filters/example_filters_provider.dart';

final exampleNotifierProvider =
    BaseStateNotifierProvider<ExampleStateNotifier, String>(
  (ref) => ExampleStateNotifier(ref.watch(exampleRepositoryProvider), ref),
);

class ExampleStateNotifier extends BaseStateNotifier<String> {
  final ExampleRepository _exampleRepository;

  ExampleStateNotifier(this._exampleRepository, super.ref) {
    on(
      exampleFiltersProvider,
      (previous, next) => getSomeStringsStreamed(),
    );
  }

  Future getSomeStringFullExample() => execute(
        //Function that is called. Needs to have the same success return type as State
        _exampleRepository.getSomeString(),

        //Set to true if you want to handle error globally (ex. Show error dialog above the entire app)
        globalFailure: true,

        //Set to true if you want to show BaseLoadingIndicator above the entire app
        globalLoading: false,

        //Set to true if you want to update state to BaseState.loading()
        withLoadingState: true,

        //Do some actions with data
        //If you return true, base state will be updated to BaseState.data(data)
        //If you return false, depending on withLoadingState, if true it will be
        //updated to BaseState.initial() otherwise won't be updated at all
        onDataReceived: (data) {
          // Custom handle data
          return true;
        },

        //Do some actions with failure
        //If you return true, base state will be updated to BaseState.error(failure)
        //If you return false, depending on withLoadingState, if true it will be
        //updated to BaseState.initial() otherwise won't be updated at all
        onFailureOccurred: (failure) {
          // Custom handle data
          return true;
        },
      );

  //Example of the API request with global loading indicator
  Future getSomeStringGlobalLoading() => execute(
        _exampleRepository.getSomeString(),
        globalLoading: true,
        withLoadingState: false,
        onDataReceived: (_) {
          setGlobalInfo(const GlobalInfo(
            globalInfoStatus: GlobalInfoStatus.info,
            title: 'test title of global info',
            message: 'test message of global info',
          ));
          return true;
        },
      );

  //Example usage of streamed method of fetching data
  //Usage could be to load data from cache then from API
  Future getSomeStringsStreamed() => executeStreamed(
        _exampleRepository.getSomeStringsStreamed(),
      );
}
