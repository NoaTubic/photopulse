import 'package:flutter/material.dart';
import 'package:photopulse/common/domain/commands/command.dart';
import 'package:photopulse/common/presentation/photo_pulse_toast.dart';

class ShowToastCommand implements Command {
  final BuildContext context;
  final String message;

  ShowToastCommand(this.context, this.message);

  @override
  void execute() {
    PhotoPulseToast(message: message).show(context);
  }
}
