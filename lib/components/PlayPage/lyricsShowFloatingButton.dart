import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/providers/showLyricsProvider.dart';

class LyricsShowFloatingButton extends ConsumerStatefulWidget{
  const LyricsShowFloatingButton({super.key});

  @override
  LyricsShowFloatingButtonState createState() => LyricsShowFloatingButtonState();
}

class LyricsShowFloatingButtonState extends ConsumerState<LyricsShowFloatingButton>{
  void onTapped(){
    ref.read(showLyricsNotifierProvider.notifier).toggleVisible();
  }

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(top: size.height * 0.14, left: size.width * 0.072),
        child: FloatingActionButton(
          onPressed: onTapped,
          backgroundColor: Theme.of(context).cardColor,
          child: const Icon(
            Icons.lyrics
          )
        )
      ),
    );
  }
}
