import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/dialogPadding.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/fileRenamer.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';

class FileRenameDialog extends StatefulWidget{

  const FileRenameDialog({super.key});

  @override
  FileRenameDialogState createState() => FileRenameDialogState();
}

class FileRenameDialogState extends State<FileRenameDialog> {
  final TextEditingController _controller = TextEditingController();
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();
  final RealmIOManager _ioManager = RealmIOManager(Music.schema);
  final FileRenamer _renamer = FileRenamer();

  String _newFilePath = "";
  String _newFileName = "";


  FileRenameDialogState(){
    String originalFileName = _player.currentMusic.name.replaceAll(".mp3", "");
    _controller.text = originalFileName;

    _removeFileNameFromPath();
  }

  void _removeFileNameFromPath(){
    _newFilePath = _player.currentMusic.path;
    _newFilePath.replaceAll(_player.currentMusic.name, "");
  }

  void _okBtnTapped(){
    final newFilePath = "$_newFileName.mp3";

    Music musicInfo = Music(
      _player.currentMusic.id, 
      _controller.text, 
      newFilePath, 
      _player.currentMusic.volume,
      _player.currentMusic.lyrics,
      _player.currentMusic.picture
    );

    _ioManager.edit(newData: musicInfo);
    _renamer.renameFile(_player.currentMusic.path, _controller.text);
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: DialogPadding(
        child: Card(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  StandardSpace(),
                  const Text("ファイル名の変更"),
                  StandardSpace(),
                  TextField(
                    controller: _controller,
                  ),
                  StandardSpace(),
                  buildBtns()
                ],
              ),
            ),
          )
        ),
      )
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
