import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/settings/globalNavigatoeKey.dart';
import 'package:musicalization/utils/Result.dart';

Future<Result> showWarnDialog(String text, {Function()? onOkTapped, Function()? onCancelTapped}) async {
  Widget buildOkButton(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(Result(isSucceeded: true)),
      child: const Text("Ok"),
    );
  }

  Widget buildCancelButton(BuildContext context) {
    return onCancelTapped != null
      ? TextButton(
          onPressed: () => Navigator.of(context).pop(Result(isSucceeded: false)),
          child: const Text("Cancel"),
        )
      : const SizedBox.shrink();
  }

  final result = await showDialog<Result>(
    barrierDismissible: false,
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Center(
          child: PageWrapper(
            child: Column(
              children: [
                const Icon(
                  Icons.warning,
                  size: 75,
                  color: Colors.red,
                ),
                const StandardSpace(),
                Column(
                  children: [
                    FittedBox(
                      child: Text(text),
                    ),
                    const StandardSpace(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildCancelButton(context),
                        buildOkButton(context),
                      ],
                    )
                  ]
                ),
                const StandardSpace(),
              ],
            )
          ),
        ),
      );
    },
  );

  return result ?? Result(isSucceeded: false);
}
