import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:musicalization/models/schema.dart';

class ScrollableMusicList extends StatefulWidget {
  final List<Music> list;
  const ScrollableMusicList({super.key, required this.list});

  @override
  ScrollableMusicListState createState() => ScrollableMusicListState();
}

class ScrollableMusicListState extends State<ScrollableMusicList> {
  final ScrollController _scrollController = ScrollController();
  final PictureBinaryConverter _converter = PictureBinaryConverter();
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();

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
              _player.start(index);
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

  Widget _buildMusicPicture(Music music) {
    ImageProvider image = _converter.convertBase64ToImage(music.picture);
    return CircleAvatar(
      foregroundImage: image,
    );
  }
}
