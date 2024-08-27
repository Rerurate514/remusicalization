import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/MyAppBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/scrollableMusicList.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/components/ListPage/registerListDialog.dart';
import 'package:musicalization/components/ListPage/registerListNameDialog.dart';
import 'package:musicalization/logic/recordFetcher.dart';
import 'package:musicalization/models/schema.dart';
import 'package:realm/realm.dart';
import 'package:musicalization/settings/globalNavigatoeKey.dart';

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

  void _onListAddBtnTapped() async {

  }

  

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MyAppBar(
        image: AssetImage("assets/images/mp3_mode_list.png")
      ),
      body: PageWrapper(
        child: Column(
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
              rightWidgetTappedCallback: _onListAddBtnTapped
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
