import 'package:flutter/widgets.dart';

class PageWrapper extends StatelessWidget{
  final Widget child;

  const PageWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.05
      ),
      child: child,
    );
  }
}