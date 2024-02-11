import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:photopulse/common/presentation/photo_pulse_text_form_field.dart';
import 'package:photopulse/common/presentation/text/label_text.dart';
import 'package:photopulse/theme/app_colors.dart';

class PostTextField extends StatefulWidget {
  final String name;
  final String label;
  final int maxCharacter;
  final TextInputType textInputType;
  final bool isMandatory;
  final List<String? Function(String?)>? validators;
  final String? initialValue;
  final Widget? action;
  final TextEditingController? textEditingController;

  const PostTextField({
    super.key,
    required this.name,
    required this.label,
    required this.maxCharacter,
    required this.textInputType,
    required this.isMandatory,
    this.validators,
    this.initialValue,
    this.action,
    this.textEditingController,
  });

  @override
  State<PostTextField> createState() => _PostTextFieldState();
}

class _PostTextFieldState extends State<PostTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.textEditingController ?? TextEditingController();
    _controller.text = widget.initialValue ?? '';
    _controller.addListener(() {
      log(
        _controller.text,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = _controller.text;
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        PhotoPulseTextFormField.postTextField(
          name: widget.name,
          labelText: widget.label,
          textInputType: widget.textInputType,
          textEditingController: _controller,
          isMandatory: widget.isMandatory,
          maxCharacterExceeded: text.runes.length >= widget.maxCharacter,
          maxCharacters: widget.maxCharacter,
          validators: widget.validators,
          initialValue: widget.initialValue,
          suffixAction: widget.action,
        ),
        LabelText(
          '${text.runes.length}/${widget.maxCharacter}',
          color: text.runes.length == widget.maxCharacter
              ? AppColors.white
              : AppColors.black,
        ),
      ],
    );
  }
}
