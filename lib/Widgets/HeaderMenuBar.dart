import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musicalization/Widgets/InkCard.dart';

class HeaderMenuBar extends StatelessWidget{
  final Widget leftWidget;
  final Widget rightWidget;

  final Function() leftWidgetTappedCallback;
  final Function() rightWidgetTappedCallback;

  const HeaderMenuBar({
    super.key, 
    required this.leftWidget,
    required this.leftWidgetTappedCallback,
    required this.rightWidget,
    required this.rightWidgetTappedCallback
  });

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildCard(
          size,
          leftWidget, 
          leftWidgetTappedCallback
        ),
        buildCard(
          size,
          rightWidget, 
          rightWidgetTappedCallback
        )
      ],
    );
  }

  Widget buildCard(Size size, Widget widget, Function() callback){
    return InkCard(
      onTap: callback,
      child: SizedBox(
        width: size.width * 0.3,
        height: size.height * 0.09,
        child: widget,
      ),
    );
  }
}