import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/enums/transition.dart';
import 'package:musicalization/logic/musicPlayer.dart';

class PreviousMusicButton extends StatelessWidget{
  final _player = MusicPlayer.getEmptyInstance();

  PreviousMusicButton({super.key});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return InkCard(
      onTap: () {
        _player.moveMusicList(Transition.PREVIOUS);
      }, 
      padding: 10,
      child: const Icon(
        Icons.skip_previous,
        size: 32,
      )
    );
  }
}
