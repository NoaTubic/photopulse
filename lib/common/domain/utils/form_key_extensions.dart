//ignore_for_file: avoid-dynamic
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loggy/loggy.dart';

extension FormKeyExtensions on GlobalKey<FormBuilderState> {
  void submitForm(Function(Map<String, dynamic> formMap) formFunction) {
    if (currentState?.saveAndValidate() ?? false) {
      final formMap = currentState!.value;
      formFunction(formMap);
    } else {
      logDebug('validation failed');
    }
  }

  void updateField(String key, dynamic value) {
    currentState?.fields[key]?.didChange(value);
  }
}

extension CheckFormIsInitial on GlobalKey<FormBuilderState> {
  bool isInitial() {
    currentState?.save();
    return currentState != null &&
        currentState!.value.values.where((value) => value != null).isEmpty;
  }
}
