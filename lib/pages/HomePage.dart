import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/MyAppBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/ScrollableMusicList.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/components/HomePage/ytDownloaderDialog.dart';
import 'package:musicalization/enums/transition.dart';
import 'package:musicalization/logic/fileImporter.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/realm/realmUpdater.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/utils/showDialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Music> _list = [];
  final Updater _updater = Updater();
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();

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

  void _onImportButtonTapped(){
    final importer = FileImporter();
    importer.importFileFromLocal();
  }

  Future<List<Music>> _updateMusicList() async {
    List<Music> list = await _updater.update();
    MusicPlayer.setMusicList(list);
    return list;
  }

  void playShuffleMusic(){
    _player.toggleMusicMode();

    _player.moveMusicList(Transition.RANDOM);
  }

  @override
  Widget build(BuildContext context) {
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
              leftWidgetTappedCallback: playShuffleMusic, 
              rightWidget: const Icon(
                Icons.download,
                size: 40,
              ),
              rightWidgetTappedCallback: () {
                showDialogWithContext(
                  YtDownloaderDialog(
                    onDownloadFinished: initList,
                  )
                );
              }
            ),
            const StandardSpace(),
            buildList()
          ],
        )
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Theme.of(context).cardColor,
            onPressed: _onImportButtonTapped,
            child: const Icon(
              Icons.storage,
              size: 32,
            ),
          ),
          const StandardSpace(),
          FloatingActionButton(
            backgroundColor: Theme.of(context).cardColor,
            onPressed: _onUpdateBtnTapped,
            child: const Icon(
              Icons.update,
              size: 32,
            ),
          ),
        ],
      )
    );
  }

  Widget buildList(){
    return ScrollableMusicList(list: _list);
  }
}
