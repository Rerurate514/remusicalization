import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/models/wrappedPlayList.dart';
import 'package:musicalization/providers/musicListInPlayListProvider.dart';

class ListRenameDialog extends ConsumerStatefulWidget{
  final WrappedPlayList wrappedPlayList;

  const ListRenameDialog({super.key, required this.wrappedPlayList});

  @override
  ListRenameDialogState createState() => ListRenameDialogState();
}

class ListRenameDialogState extends ConsumerState<ListRenameDialog>{
  String _tempListName = "";
  late final WrappedPlayList _wrappedPlayList;
  final RealmIOManager _ioManager = RealmIOManager(PlayList.schema);

  void _okBtnTapped() async {
    await _saveListName();
    ref.read(musicListInPlayListNotifierProvider.notifier).setWrappedPlayList(_wrappedPlayList);
  }

  Future<void> _saveListName() async {
    final PlayList playList = PlayList(
      widget.wrappedPlayList.id, 
      _tempListName, 
      widget.wrappedPlayList.picture,
      list: widget.wrappedPlayList.playListModel.list
    );

    _wrappedPlayList = await WrappedPlayList.getInstance(playList);

    await _ioManager.edit(
      newData: playList
    );
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.3, horizontal: size.width * 0.1),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTitle(),
                const StandardSpace(),
                buildTextField(),
                const StandardSpace(),
                buildBtns(size)
              ],
            ),
          )
        )
      )
    );
  }

  Widget buildTitle(){
    return const Text("リストの名前を変更する");
  }

  Widget buildTextField(){
    final contoroller = TextEditingController.fromValue(
      TextEditingValue(
        text: widget.wrappedPlayList.name
      )
    );
    
    return TextField(
      controller: contoroller,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: "リスト名",
      ),
      onChanged: (text) {
        _tempListName = text;
      },
    );
  }

  Widget buildBtns(Size size){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton( 
          onPressed: () {
            Navigator.pop(context);
          }, 
          child: const Text("戻る"),
        ), 
        TextButton( 
          onPressed: ()  {
            _okBtnTapped();
            Navigator.pop(context);
          },
          child: const Text("完了"),
        ), 
      ],
    );
  }
}
