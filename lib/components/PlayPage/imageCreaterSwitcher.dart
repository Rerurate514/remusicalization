import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/components/PlayPage/drawer/musicImageCreater.dart';
import 'package:musicalization/providers/showMusicImageCreater.dart';

class ImageCreaterSwitcher extends ConsumerStatefulWidget{
  const ImageCreaterSwitcher({super.key});

  @override
  ImageCreaterSwitcherState createState() => ImageCreaterSwitcherState();
}

class ImageCreaterSwitcherState extends ConsumerState<ImageCreaterSwitcher> {
  void closeFragment(){
    ref.read(showMusicImageCreaterProvider.notifier).state =
    !ref.read(showMusicImageCreaterProvider.notifier).state;
  }

  @override
  Widget build(BuildContext context){
    final showFlag = ref.watch(showMusicImageCreaterProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero
          ).animate(animation),
          child: child,
        );
      },
      child: showFlag
      ? MusicImageCreater(closeFragment: closeFragment)
      : const SizedBox.shrink(),
    );
  }
}
