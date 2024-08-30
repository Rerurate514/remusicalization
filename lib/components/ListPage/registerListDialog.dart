import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:realm/realm.dart';

class RegisterListDialog extends StatefulWidget {
  final Function(List<ObjectId>) setMusicList;

  const RegisterListDialog({super.key, required this.setMusicList});  

  @override
  RegisterListDialogState createState() => RegisterListDialogState();
}

class RegisterListDialogState extends State<RegisterListDialog> {
  final ScrollController _scrollController = ScrollController();
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();
  final PictureBinaryConverter _converter = PictureBinaryConverter();
  final RealmIOManager _ioManager = RealmIOManager(Music.schema);

  late final List<Music> _allMusicList;

  late List<bool> _selected;

  final List<ObjectId> _tempToBeAddedList = [];

  @override
  void initState(){
    super.initState();
    _readAllMusic();
    _selected = List.generate(_allMusicList.length, (index) => false);
  }

  void _readAllMusic() async {
    _allMusicList = await _ioManager.readAll();
  }

  void _okBtnTapped(){
    widget.setMusicList(_tempToBeAddedList);
  }

  void _addList(ObjectId id) {
    setState(() {
      _tempToBeAddedList.contains(id)
      ? _tempToBeAddedList.remove(id)
      : _tempToBeAddedList.add(id);
    });
  }
  
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.1, horizontal: size.width * 0.05),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StandardSpace(),
                buildTitle(),
                StandardSpace(),
                buildRegisteringList(),
                StandardSpace(),
                buildBtns(),
                StandardSpace(),
              ],
            ),
          ),
        )
      )
    );
  }

  Widget buildTitle(){
    return const Text("リストに追加する曲を選択");
  }

  Widget buildRegisteringList() {
    return Expanded( 
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _allMusicList.length,
        addAutomaticKeepAlives: true,
        itemBuilder: (_, int index){
          return InkCard(
            onTap: () {
              setState(() {
                _selected[index] = !_selected[index];
                _addList(_allMusicList[index].id);
              });
            }, 
            child: Row(
              children: [
                buildCheckBox(index),
                buildMusicInfo(index)
              ],
            )
          );
        }
      ),
    );
  }

  Widget buildCheckBox(int index){
    return Expanded(
      flex: 1,
      child: _selected[index]
      ? const Icon(Icons.check_box)
      : const Icon(Icons.check_box_outline_blank),
    );
  }

  Widget buildMusicInfo(int index){
    return Expanded(
      flex: 4,
      child: ListTile(
        leading: buildImage(index),
        title: Text(_allMusicList[index].name),
      )
    );
  }

  Widget buildImage(int index){
    return _allMusicList[index].picture != ""
      ? _buildMusicPicture(_allMusicList[index])
      : const Icon(
        Icons.image,
        size: 40,
      );
  }

  Widget _buildMusicPicture(Music music) {
    ImageProvider image = _converter.convertBase64ToImage(music.picture);
    return CircleAvatar(
      foregroundImage: image,
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

  // Future _showChoiceListMusicDialog() async {
  //   final List<MusicInfo> listInMusicInfo =
  //       _musicInfoRecordFetcher.getAllReacordList();

  //   _tempListInMusicList = [];

  //   await showDialog<List<ObjectId>>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return _ResisterListDialog(
  //           listInMusicInfo: listInMusicInfo,
  //           getMusicListCallback: _getMusicListCallback,
  //           isContinuedDialogCallback: _isContinuedDialogCallback,
  //         );
  //       });
  // }

