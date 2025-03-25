import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/enums/transition.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/sizeDiffFns.dart';

class PreviousMusicButton extends StatelessWidget{
  final _player = MusicPlayer.getEmptyInstance();

  PreviousMusicButton({super.key});

  @override
  Widget build(BuildContext context){
    return InkCard(
      onTap: () {
        _player.moveMusicList(Transition.PREVIOUS);
      }, 
      padding: 10,
      child:  Icon(
        Icons.skip_previous,
        size: getButtonsSize(),
      )
    );
  }
}
