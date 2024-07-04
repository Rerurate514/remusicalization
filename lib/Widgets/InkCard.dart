import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musicalization/enums/radius.dart';

class InkCard extends StatelessWidget{
  final Function() onTap;
  final Widget child;

  const InkCard({super.key, required this.onTap, required this.child});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: InkWell(
        borderRadius: MyBorderRadius.CARD.value,
        onTap: onTap,
        child: child
      ),
    );
  }
}