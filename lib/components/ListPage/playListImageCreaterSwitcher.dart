import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/components/ListPage/playListImageCreater.dart';
import 'package:musicalization/models/wrappedPlayList.dart';
import 'package:musicalization/providers/showPlayListImageCreater.dart';

class PlayListImageCreaterSwitcher extends ConsumerStatefulWidget{
  final WrappedPlayList wrappedPlayList;

  const PlayListImageCreaterSwitcher({super.key, required this.wrappedPlayList});

  @override
  PlayListImageCreaterSwitcherState createState() => PlayListImageCreaterSwitcherState();
}

class PlayListImageCreaterSwitcherState extends ConsumerState<PlayListImageCreaterSwitcher> {
  void closeFragment(){
    ref.read(showPlayListImageCreaterProvider.notifier).state =
    !ref.read(showPlayListImageCreaterProvider.notifier).state;
  }

  @override
  Widget build(BuildContext context){
    final showFlag = ref.watch(showPlayListImageCreaterProvider);
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
      ? PlayListImageCreater(
        closeFragment: closeFragment, 
        wrappedPlayList: widget.wrappedPlayList
      )
      : const SizedBox.shrink(),
    );
  }
}
