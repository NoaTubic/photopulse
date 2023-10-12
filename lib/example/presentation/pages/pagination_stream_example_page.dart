//ignore_for_file: always_use_package_imports

import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/q_architecture.dart';

import '../../../common/presentation/build_context_extensions.dart';
import '../../domain/notifiers/example_pagination/example_paginated_stream_notifier.dart';

class PaginationStreamExamplePage extends StatelessWidget {
  static const routeName = '/pagination-stream-example-page';

  const PaginationStreamExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream Pagination'),
      ),
      body: PaginatedListView(
        itemBuilder: (context, word) => _PaginationExampleTile(word),
        emptyListBuilder: (refresh) => Center(
          child: Text('list empty', style: context.appTextStyles.regular),
        ),
        autoDisposeStateNotifier: paginatedStreamNotifierProvider,
        onError: (failure, listIsEmpty, onRefresh) {
          logDebug('failure occurred: $failure');
          return null;
        },
      ),
    );
  }
}

class _PaginationExampleTile extends StatelessWidget {
  final String word;
  const _PaginationExampleTile(this.word);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        word,
        style: context.appTextStyles.boldLarge,
      ),
    );
  }
}
