import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/components/PlayPage/lyricsFragment.dart';
import 'package:musicalization/providers/showLyricsProvider.dart';

class LyricsSwitcher extends ConsumerStatefulWidget{
  const LyricsSwitcher({super.key});
  
  @override
  LyricsSwitcherState createState() => LyricsSwitcherState();
}

class LyricsSwitcherState extends ConsumerState<LyricsSwitcher>{

  void closeFragment(){
    ref.read(showLyricsNotifierProvider.notifier).toggleVisible();
  }

  @override
  Widget build(BuildContext context){
    final showFrag = ref.watch(showLyricsNotifierProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, animation){
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero
          ).animate(animation),
          child: child,
        );
      },
      child: showFrag
      ? LyricsFragment(closeFragment: closeFragment)
      : const SizedBox.shrink(),
    );
  }
}
