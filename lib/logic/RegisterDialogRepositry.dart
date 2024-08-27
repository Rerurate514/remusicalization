

  import 'package:flutter/material.dart';
import 'package:musicalization/components/ListPage/registerListDialog.dart';
import 'package:musicalization/components/ListPage/registerListNameDialog.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/settings/globalNavigatoeKey.dart';
import 'package:realm/realm.dart';



class RegisterDialogRepositry{
  final RealmIOManager _ioManager = RealmIOManager(PlayList.schema);

  bool _isDialogContinued = false;
  String _listName = "";
  List<ObjectId> _musicList = [];
  
  Future doSequence() async {
    await _showListNameEnteredDialog();
    if(!_isDialogContinued) return;
    await _showRegisterEnteredDialog();
    _saveList();
  }

  Future _showListNameEnteredDialog() async {
    await showDialog(
      context: navigatorKey.currentContext!, 
      builder: (BuildContext context){
        return RegisterListNameDialog(
          isDialogContinued: (bool isDialogContinued) {
            _isDialogContinued = isDialogContinued;
          }, 
          setListName: (String listName) {
            _listName = listName;
          }
        );
      }
    );
  }

  Future _showRegisterEnteredDialog() async {
    await showDialog(
      context: navigatorKey.currentContext!, 
      builder: (BuildContext context){
        return RegisterListDialog(
          setMusicList: (List<ObjectId> musicList) {
            _musicList = musicList;
          }
        );
      }
    );
  }

  void _saveList(){
    _ioManager.add<PlayList>(newData: PlayList(ObjectId(), _listName, list: _musicList));
  }
}
