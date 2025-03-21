import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ImageProvider image;

  const MyAppBar({super.key, required this.image});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("musicalization"),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Image(image: image),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
