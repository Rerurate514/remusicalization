import 'package:flutter/material.dart';

enum DrawerItemTappped {
  AUTO_VOLUME_SETTING,
  LYRICS_SETTING,
  NAME_SETTING,
  PICTURE_SETTING
}

class MusicSettingDrawer extends Drawer{
  final Map<DrawerItemTappped, Function> tappedFuncsMap;

  const MusicSettingDrawer(this.tappedFuncsMap, {super.key});

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
                  Icons.settings
                )
              ),
              const Text(
                "曲の設定",
                style: TextStyle(fontSize: 32),
              ),
            ],
          ),
          _MusicSettingDrawerItems(
            "自動音量設定",
            "assets/images/mp3_menu_auto_sound_control.png",
            tappedFuncsMap[DrawerItemTappped.AUTO_VOLUME_SETTING]!
          ),
          _MusicSettingDrawerItems(
            "歌詞の設定", 
            "assets/images/mp3_menu_lyrics_setting.png",
            tappedFuncsMap[DrawerItemTappped.LYRICS_SETTING]!
          ),
          _MusicSettingDrawerItems(
            "ファイル名の変更", 
            "assets/images/mp3_menu_name_change_button.png",
            tappedFuncsMap[DrawerItemTappped.NAME_SETTING]!
          ),
          _MusicSettingDrawerItems(
            "パケット絵の設定", 
            "assets/images/mp3_menu_picture_setting.png",
            tappedFuncsMap[DrawerItemTappped.PICTURE_SETTING]!
          ),
        ],
      ),
    );
  }
}

class _MusicSettingDrawerItems extends StatelessWidget{
  final String _itemTitle;
  final String _itemPicture;
  final Function _onItemTappedFunc;

  const _MusicSettingDrawerItems(this._itemTitle, this._itemPicture, this._onItemTappedFunc);

  @override
  Widget build(BuildContext contect){
    return Card(
      child: InkWell(
        onTap: () => _onItemTappedFunc(),
        child: ListTile(
          leading: Image.asset(
            _itemPicture,
            width: 25,
          ),
          title: Text(_itemTitle),
        ),
      )
    );
  }
}
