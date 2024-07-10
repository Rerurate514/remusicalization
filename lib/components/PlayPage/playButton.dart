import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/logic/musicPlayer.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    super.key,
  });

  @override
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();

  bool isPlaying = true;

  void onTapped(){
    _togglePlaying();
    setState(() {
      _changeIcon();
    });
  }

  void _changeIcon(){
    isPlaying = !isPlaying;
  }

  void _togglePlaying(){
    if(isPlaying){
      _player.pause();
    }
    else{
      _player.resume();
    }
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
