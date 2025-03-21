import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/dialogPadding.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';

class LyricsSettingAdjuster extends StatefulWidget{
  const LyricsSettingAdjuster({super.key});

  @override
  State<StatefulWidget> createState() => LyricsSettingAdjusterState();
}

class LyricsSettingAdjusterState extends State<LyricsSettingAdjuster>{
  final MusicPlayer _musicPlayer = MusicPlayer.getEmptyInstance();
  final RealmIOManager _ioManager = RealmIOManager(Music.schema);
  final _lyricsTextController = TextEditingController();

  String _lyrics = "";

  LyricsSettingAdjusterState(){
    _lyrics = _musicPlayer.currentMusic.lyrics;
    _lyricsTextController.text = _lyrics;
  }

  void _okBtnTapped(){
    Music musicInfo = Music(
      _musicPlayer.currentMusic.id, 
      _musicPlayer.currentMusic.name, 
      _musicPlayer.currentMusic.path, 
      _musicPlayer.currentMusic.volume,
      _lyrics,
      _musicPlayer.currentMusic.picture
    );
    _ioManager.edit<Music>(newData: musicInfo);
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: DialogPadding(
        child: Card(
          elevation: 8,
            child: SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: size.height * 0.03),
                  child: buildTitle(size)
                ),
                buildTextField(size),
                const StandardSpace(),
                buildBtns(),
                const StandardSpace()
              ],
            ),
          )
        )
      )
    );
  }

  Widget buildTitle(Size size){
    return const Text(
      "歌詞の編集",
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildTextField(Size size){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
      child: TextField(
        controller: _lyricsTextController,
        maxLines: null,
        autofocus: true,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '歌詞を入力',
        ),
        onChanged: ((value){
          _lyrics = value;
        }),
      ),
    );
  }

  Widget buildBtns(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton( 
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context), 
        ), 
        TextButton( 
          child: const Text("Ok"), 
          onPressed: () => {
            _okBtnTapped(),
            Navigator.pop(context), 
          }
        ), 
      ],
    );
  }
}
