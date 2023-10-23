// ignore_for_file: unused_element
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:photopulse/common/constants/constants.dart';
import 'package:photopulse/common/presentation/app_sizes.dart';
import 'package:photopulse/common/presentation/input_formatters/emoji_aware_length_formatter.dart';
import 'package:photopulse/common/presentation/input_formatters/rune_aware_formatter.dart';
import 'package:photopulse/theme/app_colors.dart';
import 'package:photopulse/theme/theme.dart';

class PhotoPulseTextFormField extends HookWidget {
  final String name;
  final List<String? Function(String?)>? validators;
  final String hintText;
  final String? initialValue;
  final bool isEnabled;
  final String? labelText;
  final bool isMandatory;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final TextEditingController? controller;
  final AutovalidateMode? autoValidateMode;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final EdgeInsets? padding;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final String? errorText;
  final Function()? onTap;
  final bool? enableInteractiveSelection;
  final bool readOnly;
  final FocusNode? focusNode;

  const PhotoPulseTextFormField._({
    Key? key,
    this.validators,
    required this.name,
    this.hintText = '',
    this.initialValue,
    this.isEnabled = true,
    this.labelText,
    this.isMandatory = false,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.inputFormatters,
    this.maxLines = 1,
    this.controller,
    this.autoValidateMode,
    this.suffix,
    this.border,
    this.enabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.padding,
    this.fillColor,
    this.contentPadding,
    this.errorText,
    this.onTap,
    this.enableInteractiveSelection,
    this.readOnly = false,
    this.focusNode,
  }) : super(key: key);

  factory PhotoPulseTextFormField.normalTextField({
    required String name,
    List<String? Function(String?)>? validators,
    String hintText = '',
    AutovalidateMode? autoValidateMode,
    required String labelText,
    TextInputType textInputType = TextInputType.text,
    isMandatory = false,
    int maxLines = 1,
    TextEditingController? controller,
    String? initialValue,
    FocusNode? focusNode,
    bool isEnabled = true,
  }) {
    return PhotoPulseTextFormField._(
      name: name,
      validators: validators,
      hintText: hintText,
      labelText: labelText,
      textInputType: textInputType,
      autoValidateMode: autoValidateMode,
      isMandatory: isMandatory,
      maxLines: maxLines,
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      isEnabled: isEnabled,
    );
  }

  factory PhotoPulseTextFormField.passwordTextField({
    required String name,
    List<String? Function(String?)>? validators,
    required String labelText,
    AutovalidateMode? autoValidateMode,
    isMandatory = false,
    String? errorText,
  }) {
    return PhotoPulseTextFormField._(
      name: name,
      validators: validators,
      autoValidateMode: autoValidateMode,
      labelText: labelText,
      obscureText: true,
      isMandatory: isMandatory,
      errorText: errorText,
    );
  }

  factory PhotoPulseTextFormField.addCommentTextField({
    required String name,
    String hintText = '',
    required TextInputType textInputType,
    required TextEditingController textEditingController,
    FocusNode? focusNode,
  }) {
    return PhotoPulseTextFormField._(
      name: name,
      hintText: hintText,
      maxLines: textInputType == TextInputType.multiline ? null : 1,
      textInputType: textInputType,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
        borderRadius: appBorderRadius,
        borderSide: BorderSide(color: AppColors.graysInput),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: appBorderRadius,
        borderSide: BorderSide(color: AppColors.graysInput),
      ),
      focusedErrorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      padding: EdgeInsets.zero,
      inputFormatters: [
        EmojisAwareLengthFormatter(
          allowedLength: Constants.commentMaximumCharacters,
        ),
      ],
      fillColor: Colors.transparent,
      controller: textEditingController,
      focusNode: focusNode,
    );
  }

  factory PhotoPulseTextFormField.postTextField({
    required String name,
    List<String? Function(String?)>? validators,
    hintText = '',
    required String labelText,
    TextInputType textInputType = TextInputType.text,
    isMandatory = false,
    maxCharacterExceeded = false,
    required int maxCharacters,
    required TextEditingController textEditingController,
    String? initialValue,
  }) {
    return PhotoPulseTextFormField._(
      name: name,
      validators: validators,
      hintText: hintText,
      labelText: labelText,
      textInputType: textInputType,
      isMandatory: isMandatory,
      maxLines: textInputType == TextInputType.multiline ? null : 1,
      enabledBorder: maxCharacterExceeded
          ? OutlineInputBorder(
              borderRadius: appBorderRadius,
              borderSide:
                  BorderSide(color: AppColors.alertCritical.withOpacity(0.1)),
            )
          : null,
      focusedBorder: maxCharacterExceeded
          ? OutlineInputBorder(
              borderRadius: appBorderRadius,
              borderSide: BorderSide(color: AppColors.alertCritical),
            )
          : null,
      inputFormatters: [
        RuneAwareLengthFormatter(
          allowedLength: maxCharacters,
        ),
      ],
      controller: textEditingController,
      fillColor: maxCharacterExceeded
          ? AppColors.alertCritical.withOpacity(0.1)
          : null,
      initialValue: initialValue,
    );
  }

  factory PhotoPulseTextFormField.inviteFamilyMembersTextField({
    required String name,
    List<String? Function(String?)>? validators,
    String hintText = '',
    AutovalidateMode? autoValidateMode,
    String? labelText,
    TextInputType textInputType = TextInputType.text,
    required TextEditingController textEditingController,
    // required Widget prefixIcon,
    bool isEnabled = false,
    FocusNode? focusNode,
    Key? key,
  }) {
    return PhotoPulseTextFormField._(
      isEnabled: isEnabled,
      key: key,
      name: name,
      validators: validators,
      hintText: hintText,
      labelText: labelText,
      textInputType: textInputType,
      autoValidateMode: autoValidateMode,
      controller: textEditingController,
      isMandatory: true,
      contentPadding: const EdgeInsets.fromLTRB(
        AppSizes.xLargeSpacing,
        AppSizes.normalSpacing,
        AppSizes.normalSpacing,
        AppSizes.normalSpacing,
      ),
      focusNode: focusNode,
    );
  }

  factory PhotoPulseTextFormField.pickDate({
    required String name,
    List<String? Function(String?)>? validators,
    String hintText = '',
    AutovalidateMode? autoValidateMode,
    String? labelText,
    TextInputType textInputType = TextInputType.text,
    required TextEditingController textEditingController,
    required Widget prefixIcon,
    required Function() onTap,
    String? initialValue,
  }) {
    return PhotoPulseTextFormField._(
      name: name,
      validators: validators,
      hintText: hintText,
      labelText: labelText,
      textInputType: textInputType,
      autoValidateMode: autoValidateMode,
      controller: textEditingController,
      isMandatory: true,
      prefixIcon: prefixIcon,
      onTap: onTap,
      enableInteractiveSelection: false,
      readOnly: true,
      initialValue: initialValue,
    );
  }

  // @override
  // void dispose() {
  //   if (controller == null) {
  //     _controller.dispose();
  //   }
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final isObscured = useState(obscureText);
    final controller = useTextEditingController(text: initialValue);

    useEffect(
      () {
        return () {
          // ignore: unnecessary_null_comparison
          if (controller == null) {
            controller.dispose();
          }
        };
      },
      const [],
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                TextSpan(
                  text: labelText,
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                  children: <TextSpan>[
                    isMandatory
                        ? TextSpan(
                            text: '*',
                            style: Theme.of(context)
                                .inputDecorationTheme
                                .labelStyle!
                                .copyWith(color: AppColors.alertCritical),
                          )
                        : const TextSpan(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.tinySpacing),
        ],
        FormBuilderField(
          name: name,
          autovalidateMode: autoValidateMode,
          validator: validators != null
              ? FormBuilderValidators.compose(validators!)
              : null,
          initialValue: initialValue,
          builder: (field) => TextField(
            focusNode: focusNode,
            controller: controller,
            onChanged: (value) {
              field.didChange(value);
            },
            enableInteractiveSelection: enableInteractiveSelection,
            enabled: isEnabled,
            readOnly: readOnly,
            decoration: isEnabled
                ? InputDecoration(
                    fillColor: fillColor ??
                        (field.hasError
                            ? AppColors.alertCritical.withOpacity(0.1)
                            : null),
                    errorText: errorText ?? field.errorText,
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyMedium,
                    suffix: suffix,
                    suffixIcon: obscureText
                        ? IconButton(
                            icon: Icon(
                              isObscured.value
                                  ? Icons.remove_red_eye
                                  : Icons.remove_red_eye_outlined,
                            ),
                            onPressed: () =>
                                isObscured.value = !isObscured.value,
                          )
                        : suffixIcon ??
                            (field.hasError
                                ? IconButton(
                                    onPressed: () => _clearInput(field),
                                    icon: const Icon(
                                      Icons.clear_rounded,
                                    ),
                                  )
                                : null),
                    prefixIcon: prefixIcon,
                    border: border,
                    enabledBorder: enabledBorder,
                    disabledBorder: disabledBorder,
                    focusedBorder: focusedBorder,
                    focusedErrorBorder: focusedErrorBorder,
                    errorBorder: errorBorder,
                    contentPadding: contentPadding,
                  )
                : const InputDecoration(),
            keyboardType: textInputType,
            textInputAction: textInputAction,
            obscureText: isObscured.value,
            enableSuggestions: !isObscured.value,
            autocorrect: !isObscured.value,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            onTap: onTap,
          ),
        ),
      ],
    );
  }

  void _clearInput(FormFieldState<String> field) {
    field.reset();
    controller?.clear();
  }
}
