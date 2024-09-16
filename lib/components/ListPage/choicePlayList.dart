import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/components/ListPage/scrollablePlayLists.dart';
import 'package:musicalization/logic/RegisterDialogRepositry.dart';
import 'package:musicalization/logic/recordFetcher.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/models/wrappedPlayList.dart';

class ChoicePlayList extends StatefulWidget{
  const ChoicePlayList({super.key});

  @override
  ChoicePlayListState createState() => ChoicePlayListState();
}

class ChoicePlayListState extends State<ChoicePlayList> {
  final RegisterDialogRepositry _dialogRepositry = RegisterDialogRepositry();
  final RecordFetcher<PlayList> _fetcher = RecordFetcher<PlayList>(PlayList.schema);
  
  List<WrappedPlayList> _wrappedPlayLists = [];

  @override
  void initState(){
    super.initState();

    setState(() {
      _initPlayList();
    });
  }

  void _onListAddBtnTapped() async {
    await _dialogRepositry.doAllSequence();
  }

  void _initPlayList() async {
    List<PlayList> playLists = await _fetcher.getAllReacordList();
    List<WrappedPlayList> wrappedPlayLists = [];

    for(PlayList playList in playLists){
      wrappedPlayLists.add(
        await WrappedPlayList.getInstance(playList)
      );
    }

    setState(() {
      _wrappedPlayLists = wrappedPlayLists;
    });
  }

  @override
  Widget build(BuildContext context){
    return Column(
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
    );
  }
}
