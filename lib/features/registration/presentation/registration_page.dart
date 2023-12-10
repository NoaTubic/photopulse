// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/common/presentation/photo_pulse_app_bar.dart';
import 'package:photopulse/common/presentation/photo_pulse_scaffold.dart';
import 'package:photopulse/common/presentation/photo_pulse_text__form_field.dart';
import 'package:photopulse/generated/l10n.dart';

import '../../../common/domain/router/navigation_extensions.dart';

class RegistrationPage extends ConsumerWidget {
  static const routeName = '/register';

  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PhotoPulseScaffold(
      appBar: PhotoPulseAppBar.withBackNav(title: S.current.create_new_account),
      body: ListView(
        children: [
          FormBuilder(
            child: Column(
              children: [
                PhotoPulseTextFormField.normalTextField(
                  name: 'name',
                  labelText: 'Username',
                ),
                PhotoPulseTextFormField.normalTextField(
                  name: 'name',
                  labelText: 'Email',
                ),
                PhotoPulseTextFormField.passwordTextField(
                  name: 'name',
                  labelText: 'Password',
                ),
                PhotoPulseTextFormField.passwordTextField(
                  name: 'name',
                  labelText: 'Confirm password',
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: ref.pop,
            child: const Text('Go back'),
          ),
        ],
      ),
    );
  }
}
