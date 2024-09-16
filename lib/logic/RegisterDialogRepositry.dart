import 'package:flutter/material.dart';
import 'package:musicalization/components/ListPage/registerListDialog.dart';
import 'package:musicalization/components/ListPage/registerListNameDialog.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/models/wrappedPlayList.dart';
import 'package:musicalization/settings/globalNavigatoeKey.dart';
import 'package:realm/realm.dart';



class RegisterDialogRepositry{
  final RealmIOManager _ioManager = RealmIOManager(PlayList.schema);

  bool _isDialogContinued = false;
  String _listName = "";
  List<ObjectId> _musicList = [];
  
  Future doAllSequence() async {
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

  Future _showRegisterEnteredDialog([WrappedPlayList? wrappedPlayList]) async {
    await showDialog(
      context: navigatorKey.currentContext!, 
      builder: (BuildContext context){
        return RegisterListDialog(
          isDialogContinued: (bool isDialogContinued) {
            _isDialogContinued = isDialogContinued;
          }, 
          setMusicList: (List<ObjectId> musicList) {
            _musicList = musicList;
          },
          wrappedPlayList: wrappedPlayList,
        );
      }
    );
  }

  void _saveList(){
    _ioManager.add<PlayList>(newData: PlayList(ObjectId(), _listName, "", list: _musicList));
  }

  void _editList(ObjectId id, String picture){
    _ioManager.edit<PlayList>(newData: PlayList(id, _listName, picture, list: _musicList));
  }

  Future showListNameEnteredDialog(WrappedPlayList wrappedPlayList) async {
    await _showListNameEnteredDialog();
    _musicList = wrappedPlayList.list;

    if(!_isDialogContinued) return;

    _editList(wrappedPlayList.id, wrappedPlayList.picture);
  }

  Future showRegisterEnteredDialog(WrappedPlayList wrappedPlayList) async {
    await _showRegisterEnteredDialog(wrappedPlayList);
    _listName = wrappedPlayList.name;

    if(!_isDialogContinued) return;
    
    _editList(wrappedPlayList.id, wrappedPlayList.picture);
  }
}
