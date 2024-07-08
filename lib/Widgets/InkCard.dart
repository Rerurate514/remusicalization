import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musicalization/enums/radius.dart';

class InkCard extends StatelessWidget{
  final Function() onTap;
  final Widget child;
  final double circular;
  final double padding;

  const InkCard({
    super.key, 
    required this.onTap, 
    required this.child,
    this.circular = 16.0,
    this.padding = 0.0
  });

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circular)
      ),
      child: InkWell(
        borderRadius: MyBorderRadius.CARD.value,
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: child
        )
      ),
    );
  }
}