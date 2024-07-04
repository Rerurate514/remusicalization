import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/settings/globalNavigatoeKey.dart';

showWarnDialog(String text){
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
                FittedBox(
                  child: Text(text),
                )
              ],
            )
          ),
        ),
      );
    } 
  );
}
