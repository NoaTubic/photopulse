import 'package:flutter/widgets.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:photopulse/common/presentation/validation_regex.dart';
import 'package:photopulse/generated/l10n.dart';

abstract class CommonValidators {
  static FormFieldValidator<String> password<T>() =>
      FormBuilderValidators.match(
        ValidationRegex.password,
        errorText: S.current.invalid_password_format,
      );

  static FormFieldValidator<String> email<T>() =>
      FormBuilderValidators.email(errorText: S.current.invalid_email_format);

  static String? Function(T?) requiredEmail<T>() =>
      FormBuilderValidators.required(errorText: S.current.required_email);
}
