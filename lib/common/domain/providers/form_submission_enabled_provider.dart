// ignore_for_file: avoid-dynamic
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isFormSubmissionEnabledProvider =
    StateProvider.family.autoDispose<bool, String>((ref, formId) => false);

void refreshNextEnabled({
  required GlobalKey<FormBuilderState> formKey,
  required AutoDisposeStateProviderFamily<bool, String>
      isFormSubmissionEnabledProvider,
  required WidgetRef ref,
  required dynamic formIdentifier,
}) {
  WidgetsBinding.instance.addPostFrameCallback(
    (_) {
      ref.read(isFormSubmissionEnabledProvider(formIdentifier).notifier).state =
          formKey.currentState?.saveAndValidate(focusOnInvalid: false) ?? false;
    },
  );
}
