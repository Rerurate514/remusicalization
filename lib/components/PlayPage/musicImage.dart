import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:musicalization/providers/musicImageProvider.dart';

class MusicImage extends ConsumerStatefulWidget{
  const MusicImage({super.key});

  @override
  MusicImageState createState() => MusicImageState();
}

class MusicImageState extends ConsumerState<MusicImage>{
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();
  final PictureBinaryConverter _converter = PictureBinaryConverter();

  // ignore: unused_field
  ImageProvider? _image;

  @override
  void initState(){
    super.initState();
    _setMusicPictureToImage();
  }

  void _setMusicPictureToImage() {
    setState(() {
      if(_player.currentMusic.picture != ""){
        _image = _converter.convertBase64ToImage(_player.currentMusic.picture);
      }
      else{
        _image = null;
      }
    });
  }

  void _setMusicPictureToProv(){
    ref.read(musicImageProvider.notifier).update(
      (state) =>
        _player.currentMusic.picture != ""
        ? state
        : null
    );
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    final imageProv = ref.watch(musicImageProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setMusicPictureToProv();
    });

    final double imageAvatorSize = size.height * 0.3;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000)
        ),
        elevation: 16,
        child: SizedBox(
          width: imageAvatorSize,
          height: imageAvatorSize,
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(28, 28, 28, 0),
            backgroundImage: imageProv,
            child: imageProv == null
            ? const Icon(Icons.image)
            : null,
          ),
        )
      ),
    );
  }
}
