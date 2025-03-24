import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/enums/colors.dart';
import 'package:musicalization/enums/musicMode.dart';
import 'package:musicalization/logic/musicPlayer.dart';

class MusicModeButton extends StatefulWidget {
  const MusicModeButton({super.key});

  @override
  _MusicModeButtonState createState() => _MusicModeButtonState();
}

class _MusicModeButtonState extends State<MusicModeButton> {
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();

  final Widget normalIcon = Icon(
    Icons.loop,
    color: MyColors.UNSELECTED_BLUE.color,
    size: 32,
  );

  final Widget loopIcon = const Icon(
    Icons.loop,
    size: 32,
  );

  final Widget shuffleIcon = const Icon(
    Icons.shuffle,
    size: 32,
  );

  Widget _icon = Container();

  @override
  void initState(){
    super.initState();
    _initBtnIcon();
  }

  void _initBtnIcon(){
    setState(() {
      switch(_player.musicMode){
        case MusicMode.NORMAL: {
          _icon = normalIcon;
        }
        case MusicMode.LOOP: {
          _icon = loopIcon;
        }
        case MusicMode.SHUFFLE: {
          _icon = shuffleIcon;
        }
      }
    });
  }

  void onTapped(){
    setState(() {
      switch(_player.musicMode){
        case MusicMode.NORMAL: {
          _icon = loopIcon;
        }
        case MusicMode.LOOP: {
          _icon = shuffleIcon;
        }
        case MusicMode.SHUFFLE: {
          _icon = normalIcon;
        }
      }
    });

    _player.toggleMusicMode();
  }

  @override
  Widget build(BuildContext context) {
    return InkCard(
      onTap: onTapped, 
      padding: 10,
      child: _icon
    );
  }
}
