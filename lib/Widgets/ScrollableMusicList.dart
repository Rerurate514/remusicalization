import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:musicalization/models/schema.dart';

class ScrollableMusicList extends StatefulWidget {
  final List<Music> list;
  const ScrollableMusicList({super.key, required this.list});

  @override
  _ScrollableMusicListState createState() => _ScrollableMusicListState();
}

class _ScrollableMusicListState extends State<ScrollableMusicList> {
  final ScrollController _scrollController = ScrollController();
  final _converter = PictureBinaryConverter();

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
            onTap: () {}, 
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
      // : Image.asset(
      //   _picture.musicRecordImg,
      //   width: 50,
      // );
      : const Icon(Icons.image);
  }

  Widget _buildMusicPicture(Music info) {
    ImageProvider image = _converter.convertBase64ToImage(info.picture);
    return CircleAvatar(
      foregroundImage: image,
    );
  }
}