import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/enums/colors.dart';
import 'package:musicalization/providers/showPlayListImageCreater.dart';

enum DrawerItemTappped {
  RENAME_LIST,
  RECHOICE_MUSIC,
  PICTURE_SETTING
}

class PlayListSettingDrawer extends Drawer{
  final Map<DrawerItemTappped, Function> tappedFuncsMap;

  const PlayListSettingDrawer(this.tappedFuncsMap, {super.key});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                child: const Icon(
                  Icons.settings,
                  size: 64,
                )
              ),
              const Text(
                "曲の設定",
                style: TextStyle(fontSize: 32),
              ),
            ],
          ),
          const StandardSpace(),
          buildCards()
        ],
      ),
    );
  }

  Widget buildCards(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _PlayListSettingDrawerItems(
            "リスト名の編集",
            Icons.edit_note_sharp,
            tappedFuncsMap[DrawerItemTappped.RENAME_LIST]!
          ),
          _PlayListSettingDrawerItems(
            "リスト中の曲の選択", 
            Icons.list,
            tappedFuncsMap[DrawerItemTappped.RECHOICE_MUSIC]!
          ),
          _ImageCreaterDrawerItems(
            "パケット絵の編集", 
            Icons.image,
            tappedFuncsMap[DrawerItemTappped.PICTURE_SETTING]!
          ),
        ],
      ),
    );
  }
}

class _PlayListSettingDrawerItems extends StatelessWidget{
  final String _itemTitle;
  final IconData _icon;
  final Function _onItemTappedFunc;

  const _PlayListSettingDrawerItems(this._itemTitle, this._icon, this._onItemTappedFunc);

  @override
  Widget build(BuildContext contect){
    return InkCard(
      onTap: () => _onItemTappedFunc(),
      child: ListTile(
        leading: Icon(
          _icon,
          color: MyColors.PRIMARY_BLUE.color,
        ),
        title: Text(_itemTitle),
      ),
    );
  }
}

class _ImageCreaterDrawerItems extends ConsumerStatefulWidget{
  final String itemTitle;
  final IconData icon;
  final Function onItemTappedFunc;

  const _ImageCreaterDrawerItems(this.itemTitle, this.icon, this.onItemTappedFunc);

  @override
  _ImageCreaterDrawerItemsState createState() => _ImageCreaterDrawerItemsState();
}

class _ImageCreaterDrawerItemsState extends ConsumerState<_ImageCreaterDrawerItems>{

  @override
  Widget build(BuildContext contect){
    return InkCard(
      onTap: () {
        widget.onItemTappedFunc();
        ref.read(showPlayListImageCreaterNotifierProvider.notifier).show();
      },
      child: ListTile(
        leading: Icon(
          widget.icon,
          color: MyColors.PRIMARY_BLUE.color,
        ),
        title: Text(widget.itemTitle),
      ),
    );
  }
}
