import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/validation_regex.dart';
import 'package:photopulse/features/profile/data/models/change_password_request.dart';
import 'package:photopulse/generated/l10n.dart';
import 'package:q_architecture/q_architecture.dart';

final changePasswordFormMapper = Provider<FormMapper<ChangePasswordRequest>>(
  (_) => ChangePasswordFormConfig.passwordFromJson,
);

abstract class ChangePasswordFormConfig {
  static const oldPasswordKey = 'oldPassword';
  static const newPasswordKey = 'newPassword';
  static const repeatedPasswordKey = 'repeatedPassword';

  static ChangePasswordRequest passwordFromJson(
    Map<String, dynamic> formMap,
  ) =>
      ChangePasswordRequest(
        oldPassword: formMap[oldPasswordKey],
        newPassword: formMap[newPasswordKey],
        repeatNewPassword: formMap[repeatedPasswordKey],
      );

  static String? Function(T?) isRequired<T>() => FormBuilderValidators.required(
        errorText: S.current.incorrect_password_format,
      );

  static FormFieldValidator<String> password<T>() =>
      FormBuilderValidators.match(
        ValidationRegex.password,
        errorText: S.current.incorrect_password_format,
      );

  static String? Function(T?) passwordMatch<T>({String? password}) =>
      FormBuilderValidators.equal(
        password ?? '',
        errorText: S.current.passwords_dont_match,
      );
}
