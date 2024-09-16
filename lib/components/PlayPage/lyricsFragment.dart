import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/musicPlayer.dart';

class LyricsFragment extends StatefulWidget{
  final Function() closeFragment;

  const LyricsFragment({super.key, required this.closeFragment});

  @override
  LyricsFragmentState createState() => LyricsFragmentState();
}

class LyricsFragmentState extends State<LyricsFragment>{
  final MusicPlayer _musicPlayer = MusicPlayer.getEmptyInstance();

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height * 0.9,
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.2),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(64),
            topRight: Radius.circular(64)
          ),
          child: Expanded(
            child: Card(
              child: Column(
                children: [
                  const StandardSpace(),
                  buildHeader(size),
                  const StandardSpace(),
                  Text(_musicPlayer.currentMusic.lyrics)
                ],
              ),
            )
          ),
        )
      )
    );
  }

  Widget buildHeader(Size size){
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: size.width * 0.06),
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: widget.closeFragment, 
              icon: const Icon(Icons.arrow_back)
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.lyrics),
            const StandardSpace(),
            const Text("歌詞")
          ]
        ),
      ],
    );
  }
}

