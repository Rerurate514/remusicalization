import 'dart:async';

import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/components/PlayPage/drawer/autoVolumeSettingAdjuster.dart';
import 'package:musicalization/components/PlayPage/drawer/lyricsSettingAdjuster.dart';
import 'package:musicalization/components/PlayPage/lyricsShowFloatingButton.dart';
import 'package:musicalization/components/PlayPage/lyricsSwitcher.dart';
import 'package:musicalization/components/PlayPage/musicModeButton.dart';
import 'package:musicalization/components/PlayPage/musicSettingDrawer.dart';
import 'package:musicalization/components/PlayPage/nextMusicButton.dart';
import 'package:musicalization/components/PlayPage/playButton.dart';
import 'package:musicalization/components/PlayPage/previousButton.dart';
import 'package:musicalization/components/PlayPage/volumeButton.dart';
import 'package:musicalization/components/PlayPage/volumeSwitcher.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/settings/globalNavigatoeKey.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({super.key});

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late final MusicPlayer _player;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _musicName = "null";
  String _listNane = "";
  
  double _musicDuration = 100.0;
  double _musicCurrent = 0.0;

  String _musicDurText = "null";
  String _musicCurText = "null";

  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  void _closeDrawer() => _scaffoldKey.currentState?.closeDrawer();

  @override
  void initState(){
    super.initState();
    _player = MusicPlayer.getInstanceWithReRender(_reRenderUI);
  
    _reRenderUI();

    Timer.periodic(const Duration(milliseconds:  100), (timer) {
      _setMusicDurCur();
    });
  }

  void _reRenderUI(){
    setState(() {
      _listNane = _player.listName;
      _musicName = _player.currentMusic.name;
    });
  }

  void _setMusicDurCur() {
    if (mounted) {
      setState(() {
        _musicDuration = _player.durationSeconds;
        _musicCurrent = _player.currentSeconds;
      });
    }

    _musicCurText = "${_musicCurrent.toInt().toString()} s";
    _musicDurText = "${_musicDuration.toInt().toString()} s";
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: PageWrapper(
        child: Center(
          child: Stack(
            children: [
              Column(
                children: [
                  StandardSpace(),
                  buildTitle(),
                  StandardSpace(),
                  buildImage(size),
                  StandardSpace(),
                  buildTimeAndSlider(),
                  StandardSpace(),
                  buildButtons(),
                ],
              ),
              buildSwitchers()
            ],
          ),
        )
      ),
      drawer: MusicSettingDrawer(_DrawerTappedFuncs().tappedFuncMap),
      floatingActionButton: buildFloatingButtons(size)
    );
  }

  Widget buildTitle(){
    return Column(
      children: [
          Text(_listNane),
          StandardSpace(),
          FittedBox(
            child: Text(_musicName),
          )
      ],
    );
  }
  
  Widget buildImage(Size size){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000)
        ),
        elevation: 16,
        child: SizedBox(
          width: size.width * 0.74,
          height: size.height * 0.34,
          child: const CircleAvatar(
            backgroundColor: Color.fromARGB(28, 28, 28, 0),
            child: Icon(Icons.image)
          ),
        )
      ),
    );
  }

  Widget buildTimeAndSlider(){
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_musicCurText),
            const Text("   /   "),
            Text(_musicDurText),
          ],
        ),
        buildMusicCurrentSlider(),
      ]),
    );
  }

  Widget buildMusicCurrentSlider(){
    return Slider(
      value: _musicCurrent,
      onChanged: (currentValue) {
        setState(() {
          _musicCurrent = currentValue;
          _player.seek(_musicCurrent);
        });
      },
      min: 0,
      max: _musicDuration,
    );
  }

  Widget buildButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PreviousMusicButton(),
        const MusicModeButton(),
        const PlayButton(),
        const VolumeButton(),
        NextMusicButton()
      ],
    );
  }

  Widget buildButton(Function() onTap, IconData icon){
    return InkCard(
      onTap: onTap, 
      padding: 10,
      child: Icon(
        icon,
        size: 32,
      )
    );
  }

  Widget buildSwitchers(){
    return const Column(
      children: [
        VolumeSwitcher(),
        LyricsSwitcher()
      ],
    );
  }

  Widget buildFloatingButtons(Size size){
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.14, right: size.width * 0.002),
            child: FloatingActionButton(
              onPressed: () => _openDrawer(),
              backgroundColor: Theme.of(context).cardColor,
              child: const Icon(
                Icons.menu,
                size: 40,
              ),
            )
          ),
        ),
        const LyricsShowFloatingButton()
      ],
    );
  }
}

class _DrawerTappedFuncs{
  late final Map<DrawerItemTappped, Function> _tappedFuncsMap;
  Map<DrawerItemTappped, Function> get tappedFuncMap => _tappedFuncsMap;

  _DrawerTappedFuncs(){
    _tappedFuncsMap = {
      DrawerItemTappped.AUTO_VOLUME_SETTING: _autoVolumeSettingItemTapped,
      DrawerItemTappped.LYRICS_SETTING: _lyricsSettingItemTapped,
      DrawerItemTappped.NAME_SETTING: _nameSettingItemTapped,
      DrawerItemTappped.PICTURE_SETTING: _pictureSettingItemTapped,
    };
  }

  void _showDialog(Widget content){
    showDialog(
      context: navigatorKey.currentContext!, 
      builder: (BuildContext context) {
        return content;
      }
    );
  }
  
  void _autoVolumeSettingItemTapped(){
    _showDialog(AutoVolumeSettingAdjuster());
  }

  void _lyricsSettingItemTapped() {
    _showDialog(LyricsSettingAdjuster());
  }

  void _nameSettingItemTapped() {
    //_showDialog(const FileRenameDialog());
  }

  void _pictureSettingItemTapped() {
    //_isShowPictureSetting = !_isShowPictureSetting;
    //_closeDrawer();
  }

}

