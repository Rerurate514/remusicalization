import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:musicalization/models/wrappedPlayList.dart';
import 'package:musicalization/providers/isPlayListSelectedProvider.dart';
import 'package:musicalization/providers/musicListInPlayListProvider.dart';

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

  void onListTapped(int index){
    ref.watch(isPlayListSelectedProvider.notifier).state = true;
    ref.watch(musicListInPlayListProvider.notifier).state = widget.list[index].musicList;
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
}
