import 'package:flutter/widgets.dart';

class StandardSpace extends StatelessWidget{

  StandardSpace(){}

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.05,
      height: size.height * 0.03,
    );
  }
}