import 'package:flutter/material.dart';
import 'package:musicalization/settings/globalNavigatoeKey.dart';

void showDialogWithContext(Widget content) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return content;
    }
  );
}
