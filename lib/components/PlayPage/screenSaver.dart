import 'package:flutter/material.dart';

class ScreenSaver extends StatefulWidget {
  const ScreenSaver({super.key});

  @override
  State<ScreenSaver> createState() => _ScreenSaverState();
}

class _ScreenSaverState extends State<ScreenSaver> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Color.fromARGB(200, 32, 32, 32)
      ),
      child: const Center(
        child: Text(
          "Select Music!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32
          ),
        ),
      ),
    );
  }
}
