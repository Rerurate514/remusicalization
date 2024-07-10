import 'package:flutter/material.dart';
import 'package:musicalization/components/PlayPage/volumeControlBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/providers/showVolumeSliderProvider.dart';

class VolumeSwitcher extends ConsumerStatefulWidget {
  const VolumeSwitcher({super.key});

  @override
  VolumeSwitcherState createState() => VolumeSwitcherState();
}

class VolumeSwitcherState extends ConsumerState<VolumeSwitcher> {
  
  void closeFragment(){
    ref.read(showVolumeSliderProvider.notifier).state = 
    !ref.read(showVolumeSliderProvider.notifier).state;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final showSlider = ref.watch(showVolumeSliderProvider);
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero
          ).animate(animation),
          child: child,
        );
      },
      child: showSlider
      ? VolumeControlBar(closeFragment: closeFragment)
      : const SizedBox.shrink(),
    );
  }
}
