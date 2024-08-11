import 'package:flutter/material.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';

class MusicImage extends StatefulWidget{
  const MusicImage({super.key});

  @override
  MusicImageState createState() => MusicImageState();
}

class MusicImageState extends State<MusicImage>{
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();
  final PictureBinaryConverter _converter = PictureBinaryConverter();

  ImageProvider? _musicImage;

  @override
  void initState(){
    super.initState();
    _setMusicPicture();
  }

  void _setMusicPicture() {
    setState(() {
      if(_player.currentMusic.picture != ""){
        _musicImage = _converter.convertBase64ToImage(_player.currentMusic.picture);
      }
      else{
        _musicImage = null;
      }
    });
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000)
        ),
        elevation: 16,
        child: SizedBox(
          width: size.width * 0.74,
          height: size.height * 0.34,
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(28, 28, 28, 0),
            backgroundImage: _musicImage,
            child: _musicImage == null
            ? const Icon(Icons.image)
            : null,
          ),
        )
      ),
    );
  }
}
