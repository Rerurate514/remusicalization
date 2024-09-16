
import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/ScrollableMusicList.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/RegisterDialogRepositry.dart';
import 'package:musicalization/logic/recordFetcher.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/models/wrappedPlayList.dart';

class ChoiceMusic extends StatefulWidget {
  final WrappedPlayList wrappedPlayList;

  const ChoiceMusic({super.key, required this.wrappedPlayList});

  @override
  ChoiceMusicState createState() => ChoiceMusicState();
}

class ChoiceMusicState extends State<ChoiceMusic>{
  final RecordFetcher<Music> _fetcher = RecordFetcher<Music>(Music.schema);
  final RegisterDialogRepositry _repositry = RegisterDialogRepositry();

  @override
  void initState(){
    super.initState();

    setState(() {
      
    });
  }

  void _addMusicToPlayList(){
    _repositry.showRegisterEnteredDialog(widget.wrappedPlayList);
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          const StandardSpace(),
          HeaderMenuBar(
            leftWidget: const Icon(
              Icons.shuffle,
              size: 40,
            ), 
            leftWidgetTappedCallback: () {}, 
            rightWidget: const Icon(
              Icons.playlist_add,
              size: 40,
            ), 
            rightWidgetTappedCallback: _addMusicToPlayList
          ),
          const StandardSpace(),
          ScrollableMusicList(list: widget.wrappedPlayList.musicList)
        ],
      ),
    );
  }
}
