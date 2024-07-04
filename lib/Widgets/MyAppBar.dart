import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAppBar extends StatelessWidget{
  final ImageProvider image;

  const MyAppBar({super.key, required this.image});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return AppBar(
      title: const Text("musicalization"),
      actions: [
        Image(image: image)
      ],
    );
  }
}