import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/scrollableMusicList.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/recordFetcher.dart';
import 'package:musicalization/models/schema.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Music> _list = [];

  final _recordFetcher = RecordFetcher<Music>(Music.schema);

  @override
  void initState(){
    super.initState();

    setState(() {
      _list = _recordFetcher.getAllReacordList();
    });
  }

  void _onUpdateBtnTapped(){

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageWrapper(
        child: Column(
          children: [
            HeaderMenuBar(
              leftWidget: const Icon(
                Icons.shuffle,
                size: 40,
              ), 
              leftWidgetTappedCallback: () {}, 
              rightWidget: const Icon(
                Icons.add_to_drive_outlined,
                size: 40,
              ), 
              rightWidgetTappedCallback: () {}
            ),
            StandardSpace(),
            ScrollableMusicList(list: _list)
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        onPressed: _onUpdateBtnTapped,
        child: const Icon(
          Icons.update,
          size: 32,
        ),
      ),
    );
  }
}