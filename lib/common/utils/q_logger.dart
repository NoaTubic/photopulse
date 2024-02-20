// ignore_for_file: always_use_package_imports

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';

import '../../main/app_environment.dart';

class PPLogger extends StatelessWidget {
  const PPLogger._();

  static void showLogger(BuildContext context) {
    if (!EnvInfo.isProduction || kDebugMode) {
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) => const PPLogger._(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: Navigator.of(context).pop,
                icon: const Icon(Icons.close),
              ),
            ),
            const Expanded(child: LoggyStreamWidget()),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: const Text('Copy log'),
                    onPressed: () async {
                      final StreamPrinter? printer =
                          Loggy.currentPrinter is StreamPrinter
                              ? Loggy.currentPrinter as StreamPrinter?
                              : null;
                      if (printer == null) return;
                      var logList = printer.logRecord.value;
                      if (logList.length > 2000) {
                        logList = logList.sublist(0, 2000);
                      }
                      final text = StringBuffer(logList).toString();
                      Clipboard.setData(ClipboardData(text: text));
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Log copied to clipboard'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DisabledPrinter extends LoggyPrinter {
  const DisabledPrinter() : super();

  @override
  void onLog(LogRecord record) {}
}
