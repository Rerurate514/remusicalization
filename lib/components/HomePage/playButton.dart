import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    super.key,
  });

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool isPlaying = true;

  void onTapped(){
    setState(() {
      _changeIcon();
    });
  }

  void _changeIcon(){
    isPlaying = !isPlaying;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkCard(
      onTap: onTapped, 
      padding: 10,
      child: Icon(
        isPlaying ? Icons.pause : Icons.play_arrow,
        size: 32,
      )
    );
  }
}
