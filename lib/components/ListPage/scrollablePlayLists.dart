import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/enums/colors.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/models/wrappedPlayList.dart';
import 'package:musicalization/providers/isPlayListSelectedProvider.dart';
import 'package:musicalization/providers/musicListInPlayListProvider.dart';
import 'package:musicalization/utils/Result.dart';
import 'package:musicalization/utils/showWarnDialog.dart';

class ScrollablePlayLists extends StatefulWidget {
  final List<WrappedPlayList> list;

  const ScrollablePlayLists({super.key, required this.list});

  @override
  ScrollablePlayListsState createState() => ScrollablePlayListsState();
}

class ScrollablePlayListsState extends State<ScrollablePlayLists> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded( 
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.list.length,
        addAutomaticKeepAlives: true,
        itemBuilder: (_, int index){
          return PlayListsItem(
            list: widget.list,
            index: index
          );
        }
      ),
    );
  }
}

class PlayListsItem extends ConsumerStatefulWidget {
  final int index;
  final List<WrappedPlayList> list;

  const PlayListsItem({super.key, required this.list, required this.index});

  @override
  PlayListItemState createState() => PlayListItemState();
}

class PlayListItemState extends ConsumerState<PlayListsItem> {
  final PictureBinaryConverter _converter = PictureBinaryConverter();
  late final MusicPlayer _player;
  final RealmIOManager _ioManager = RealmIOManager(PlayList.schema);

  void onListTapped(int index) {
    ref.watch(isPlayListSelectedProvider.notifier).state = true;
    ref.watch(musicListInPlayListProvider.notifier).state = widget.list[index];
    _player = MusicPlayer.setMusicList(
      widget.list[index].musicList, 
      widget.list[index].name
    );
  }

  void onPlayListDeleteButton(int index) async {
    final Result result = await showWarnDialog(
      "このプレイリストを削除しますか？\nリスト名 : ${widget.list[index].name}",
      onOkTapped: () {},
      onCancelTapped: () {}
    );
    if(!result.isSucceeded) return;
    _ioManager.delete<PlayList>(id: widget.list[index].id);
  }

  @override
  Widget build(BuildContext context) {
    return InkCard(
      onTap: () {
        onListTapped(widget.index);
      }, 
      child: ListTile(
        leading: buildImage(widget.index),
        title: Text(widget.list[widget.index].name),
        trailing: buildPlayListDeleteButton(),
      )
    );
  }

  Widget buildImage(int index){
    return widget.list[index].picture != ""
      ? _buildMusicPicture(widget.list[index])
      : const Icon(
        Icons.image,
        size: 40,
      );
  }

  Widget _buildMusicPicture(WrappedPlayList playList) {
    ImageProvider image = _converter.convertBase64ToImage(playList.picture);
    return CircleAvatar(
      foregroundImage: image,
    );
  }

  Widget buildPlayListDeleteButton(){
    return IconButton(
      onPressed: () => onPlayListDeleteButton(widget.index),
      icon: Icon(
          Icons.delete,
          size: 30,
          color: MyColors.PRIMARY_BLUE.color,
        ),  
    );
  }
}
