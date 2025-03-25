import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/sizeDiffFns.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PlayButtonState createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();

  bool isPlaying = true;

  @override
  void initState(){
    super.initState();
    isPlaying = _player.isPlaying;
  }

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
    return InkCard(
      onTap: onTapped, 
      padding: 10,
      child: Icon(
        _player.isPlaying ? Icons.pause : Icons.play_arrow,
        size: getButtonsSize(),
      )
    );
  }
}
