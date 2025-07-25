import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/enums/transition.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:musicalization/logic/sizeDiffFns.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/providers/musicImageProvider.dart';

class NextMusicButton extends ConsumerStatefulWidget {
  const NextMusicButton({super.key});

  @override
  ConsumerState<NextMusicButton> createState() => _NextMusicButtonState();
}

class _NextMusicButtonState extends ConsumerState<NextMusicButton> {
  final _player = MusicPlayer.getEmptyInstance();
  final PictureBinaryConverter _converter = PictureBinaryConverter();

  void _setMusicPictureToProv() {
    ref.read(musicImageNotifierProvider.notifier).update(
      _player.currentMusic.picture != "" 
      ? _converter.convertBase64ToImage(_player.currentMusic.picture)
      : null
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkCard(
      onTap: () {
        _player.moveMusicList(Transition.NEXT);
        _setMusicPictureToProv();
      },
      padding: 10,
      child: Icon(
        Icons.skip_next,
        size: getButtonsSize(),
      )
    );
  }
}
