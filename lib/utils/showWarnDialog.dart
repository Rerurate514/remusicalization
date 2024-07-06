import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/settings/globalNavigatoeKey.dart';

showWarnDialog(String text, [Widget? child]){
  showDialog(
    barrierDismissible: false,
    context: navigatorKey.currentContext!,
    builder: (BuildContext context){
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
                StandardSpace(),
                Column(
                  children: [
                    FittedBox(
                      child: Text(text),
                    ),
                    StandardSpace(),
                    child ?? const SizedBox.shrink()
                  ]
                ),
                StandardSpace(),
              ],
            )
          ),
        ),
      );
    } 
  );
}
