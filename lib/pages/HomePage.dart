import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/MyAppBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/ScrollableMusicList.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/realm/realmUpdater.dart';
import 'package:musicalization/logic/recordFetcher.dart';
import 'package:musicalization/models/schema.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Music> _list = [];
  Updater _updater = Updater();

  MusicPlayer _musicPlayer = MusicPlayer.getEmptyInstance();
  final _recordFetcher = RecordFetcher<Music>(Music.schema);

  @override
  void initState(){
    super.initState();

    //_updateMusicList();
  }

  void _onUpdateBtnTapped() async { 
    List<Music> list = await _updateMusicList();
    list.forEach((var a) {
      print("${a.name}");
    });
    setState(() {
      _list = list;
    });
  }

  Future<List<Music>> _updateMusicList() async {
    await _updater.update();
    List<Music> list = await _recordFetcher.getAllReacordList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MyAppBar(
        image: AssetImage("assets/images/mp3_mode_main.png")
      ),
      body: PageWrapper(
        child: Column(
          children: [
            const StandardSpace(),  
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
            const StandardSpace(),
            buildList()
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

  Widget buildList(){
    return FutureBuilder(
      future: _updateMusicList(), 
      builder: (_, snapshot){
        _list = snapshot.data ?? [];
        _musicPlayer = MusicPlayer.setMusicList(_list);
        return ScrollableMusicList(list: _list);
      }
    );
  }
}
