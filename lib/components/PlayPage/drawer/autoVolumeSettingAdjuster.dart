

import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';

class AutoVolumeSettingAdjuster extends StatefulWidget{
  const AutoVolumeSettingAdjuster({super.key});

  @override
  State<StatefulWidget> createState() => AutoVolumeSettingAdjusterState();
}

class AutoVolumeSettingAdjusterState extends State<AutoVolumeSettingAdjuster>{
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();
  final RealmIOManager _ioManager = RealmIOManager(Music.schema);
  
  double _decideVolume = 0;

  AutoVolumeSettingAdjusterState(){
    _decideVolume = _player.currentMusic.volume.toDouble();
  }

  void _okBtnTapped(){
    Music musicInfo = Music(
      _player.currentMusic.id, 
      _player.currentMusic.name, 
      _player.currentMusic.path, 
      _decideVolume.toInt(),
      _player.currentMusic.lyrics,
      _player.currentMusic.picture
    );
    _ioManager.edit<Music>(newData: musicInfo);
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.3, horizontal: size.width * 0.1),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTitle(size),
              const StandardSpace(),
              buildSlider(size),
              const StandardSpace(),
              buildBtns(size)
            ],
          ),
        )
      )
    );
  }

  Widget buildTitle(Size size){
    return const Text(
      "自動に調整される音量の調整",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildSlider(Size size){
    return Column(
      children: [
        Text("${_decideVolume.toInt()}"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.065),
          child: Slider(
            value: _decideVolume,
            onChanged: (currentValue) {
              setState(() {
                _decideVolume = currentValue;
              });
            },
            min: 0,
            max: 100,
          ),
        )
      ],
    );
  }

  Widget buildBtns(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton( 
          onPressed: () => Navigator.pop(context), 
          child: const Text("戻る"),
        ), 
        TextButton( 
          onPressed: () => {
            _okBtnTapped(),
            Navigator.pop(context), 
          },
          child: const Text("完了"),
        ), 
      ],
    );
  }
}
