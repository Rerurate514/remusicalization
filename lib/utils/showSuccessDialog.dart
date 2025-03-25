import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/settings/globalNavigatorKey.dart';
import 'package:musicalization/utils/Result.dart';

Future<Result> showSuccessDialog(
  String text, {
  Function()? onOkTapped,
}) async {
  Widget buildOkButton(BuildContext context) {
    return TextButton(
            onPressed: () {
              if(onOkTapped != null) onOkTapped();
              Navigator.of(context).pop(Result(isSucceeded: true));
            },
            child: const Text("Ok"),
          );
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
                  Icons.check,
                  size: 75,
                  color: Colors.green,
                ),
                const StandardSpace(),
                Column(
                  children: [
                    Text(
                      text,
                      softWrap: true,
                    ),  
                    const StandardSpace(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: buildOkButton(context),
                    )
                  ],
                ),
                const StandardSpace(),
              ],
            ),
          ),
        ),
      );
    },
  );

  return result ?? Result(isSucceeded: false);
}
