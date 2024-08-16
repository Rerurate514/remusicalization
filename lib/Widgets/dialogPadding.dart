import 'package:flutter/material.dart';

class DialogPadding extends StatelessWidget {
  final Widget child;

  const DialogPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.3, horizontal: size.width * 0.1),
      child: child,
    );
  }
}