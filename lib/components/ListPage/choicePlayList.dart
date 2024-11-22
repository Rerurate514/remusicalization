import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/components/ListPage/scrollablePlayLists.dart';
import 'package:musicalization/logic/RegisterDialogRepositry.dart';
import 'package:musicalization/logic/recordFetcher.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/models/wrappedPlayList.dart';
import 'package:musicalization/utils/listShower.dart';

class ChoicePlayList extends StatefulWidget{
  const ChoicePlayList({super.key});

  @override
  ChoicePlayListState createState() => ChoicePlayListState();
}

class ChoicePlayListState extends State<ChoicePlayList> {
  final RegisterDialogRepositry _dialogRepositry = RegisterDialogRepositry();
  
  List<WrappedPlayList> _wrappedPlayLists = [];

  @override
  void initState(){
    super.initState();

    _initPlayList();
  }

  void _onListAddBtnTapped() async {
    await _dialogRepositry.doAllSequence();
    _initPlayList();
  }

  void _initPlayList() async {
    final RecordFetcher<PlayList> fetcher = RecordFetcher<PlayList>(PlayList.schema);
    List<PlayList> playLists = await fetcher.getAllReacordList();
    
    final List<WrappedPlayList> wrappedPlayLists = await Future.wait(
      playLists.map((playList) => WrappedPlayList.getInstance(playList))
    );

    setState(() {
      _wrappedPlayLists = wrappedPlayLists;
    });
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
            rightWidgetTappedCallback: _onListAddBtnTapped
          ),
          const StandardSpace(),
          ScrollablePlayLists(
            list: _wrappedPlayLists,
          )
        ],
      ),
    );
  }
}
