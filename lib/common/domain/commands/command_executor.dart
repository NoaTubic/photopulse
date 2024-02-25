import 'package:photopulse/common/domain/commands/command.dart';

class CommandExecutor {
  final bool condition;
  final Command trueCommand;
  final Command falseCommand;

  CommandExecutor({
    required this.condition,
    required this.trueCommand,
    required this.falseCommand,
  });

  void execute() {
    if (condition) {
      trueCommand.execute();
    } else {
      falseCommand.execute();
    }
  }
}
