
import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/ScrollableMusicList.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/recordFetcher.dart';
import 'package:musicalization/models/schema.dart';

class ChoiceMusic extends StatefulWidget {
  final List<Music> list;

  const ChoiceMusic({super.key, required this.list});

  @override
  ChoiceMusicState createState() => ChoiceMusicState();
}

class ChoiceMusicState extends State<ChoiceMusic>{
  final RecordFetcher<Music> _fetcher = RecordFetcher<Music>(Music.schema);

  @override
  void initState(){
    super.initState();

    setState(() {
      
    });
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: [
          StandardSpace(),
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
            rightWidgetTappedCallback: () {}
          ),
          StandardSpace(),
          ScrollableMusicList(list: widget.list)
        ],
      ),
    );
  }
}
