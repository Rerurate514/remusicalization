import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/MyAppBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/ScrollableMusicList.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/realm/realmUpdater.dart';
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

  @override
  void initState(){
    super.initState();

    initList();
  }

  void initList() async {
    List<Music> list = await _updateMusicList();
    setState(() {
      _list = list;
    });
  }

  void _onUpdateBtnTapped() async {
    initList();
  }

  Future<List<Music>> _updateMusicList() async {
    List<Music> list = await _updater.update();
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

  // Widget buildList(){
  //   return FutureBuilder(
  //     future: _musicListFuture, 
  //     builder: (_, snapshot){
  //       if(snapshot.hasData){
  //         _list = snapshot.data ?? [];
  //         _musicPlayer = MusicPlayer.setMusicList(_list);
  //         print(_list.length);
  //         return ScrollableMusicList(list: _list);
  //       }
  //       return const Center(child: CircularProgressIndicator());
  //     }
  //   );
  // }

  Widget buildList(){
    return ScrollableMusicList(list: _list);
  }
}
