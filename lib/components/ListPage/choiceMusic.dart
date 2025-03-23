
import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/ScrollableMusicList.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/components/ListPage/listRenameDialog.dart';
import 'package:musicalization/components/ListPage/playListImageCreaterSwitcher.dart';
import 'package:musicalization/components/ListPage/playListSettingDrawer.dart';
import 'package:musicalization/logic/RegisterDialogRepositry.dart';
import 'package:musicalization/logic/recordFetcher.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/models/wrappedPlayList.dart';
import 'package:musicalization/utils/showDialog.dart';

class ChoiceMusic extends StatefulWidget {
  final WrappedPlayList wrappedPlayList;

  const ChoiceMusic({super.key, required this.wrappedPlayList});

  @override
  ChoiceMusicState createState() => ChoiceMusicState();
}

class ChoiceMusicState extends State<ChoiceMusic>{
  final RecordFetcher<Music> _fetcher = RecordFetcher<Music>(Music.schema);
  final RegisterDialogRepositry _repositry = RegisterDialogRepositry();
  late WrappedPlayList _wrappedPlayList;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _openDrawer() => _scaffoldKey.currentState?.openDrawer();
  void _closeDrawer() => _scaffoldKey.currentState?.closeDrawer();

  @override
  void initState(){
    super.initState();

    setState(() {
      _wrappedPlayList = widget.wrappedPlayList;
    });
  }

  Future<void> _addMusicToPlayList() async {
    await _repositry.showRegisterEnteredDialog(widget.wrappedPlayList);
  }

  void _initPlayList() async {
    final RecordFetcher<PlayList> fetcher = RecordFetcher<PlayList>(PlayList.schema);
    PlayList playList = await fetcher.getRecordFromId(_wrappedPlayList.id);

    final WrappedPlayList wrappedPlayList = await WrappedPlayList.getInstance(playList);

    setState(() {
      _wrappedPlayList = wrappedPlayList;
    });
  }

  void _showEditRenameDialog(){
    showDialogWithContext(
      ListRenameDialog(
        wrappedPlayList: _wrappedPlayList
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      body: PageWrapper(
        child: Stack(
          children: [
            Column(
              children: [
                const StandardSpace(),
                HeaderMenuBar(
                  leftWidget: const Icon(
                    Icons.shuffle,
                    size: 40,
                  ), 
                  leftWidgetTappedCallback: () {}, 
                  rightWidget: const Icon(
                    Icons.settings,
                    size: 40,
                  ), 
                  rightWidgetTappedCallback: _openDrawer
                ),
                const StandardSpace(),
                ScrollableMusicList(list: _wrappedPlayList.musicList)
              ],
            ),
            PlayListImageCreaterSwitcher(wrappedPlayList: _wrappedPlayList)
          ],
        )
      ),
      drawer: PlayListSettingDrawer({
        DrawerItemTappped.RENAME_LIST: _renameListItemTapped,
        DrawerItemTappped.RECHOICE_MUSIC: _rechoiceMusicItemTapped,
        DrawerItemTappped.PICTURE_SETTING: _pictureSettingItemTapped
      }),
    );
  }

  void _renameListItemTapped() async {
    _showEditRenameDialog();
    _closeDrawer();
  }

  void _rechoiceMusicItemTapped() async {
    await _addMusicToPlayList();
    _initPlayList();
    _closeDrawer();
  }

  void _pictureSettingItemTapped() {
    _closeDrawer();
  }
}
