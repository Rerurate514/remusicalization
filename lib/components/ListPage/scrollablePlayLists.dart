import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:musicalization/models/wrappedPlayList.dart';

class ScrollablePlayLists extends StatefulWidget {
  final List<WrappedPlayList> list;
  final Function(int) onListTapped;

  const ScrollablePlayLists({super.key, required this.list, required this.onListTapped});

  @override
  ScrollablePlayListsState createState() => ScrollablePlayListsState();
}

class ScrollablePlayListsState extends State<ScrollablePlayLists> {
  final ScrollController _scrollController = ScrollController();
  final PictureBinaryConverter _converter = PictureBinaryConverter();

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
          return InkCard(
            onTap: () {
              widget.onListTapped(index);
            }, 
            child: ListTile(
              leading: buildImage(index),
              title: Text(widget.list[index].name),
            )
          );
        }
      ),
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