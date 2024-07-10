import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/providers/showVolumeSliderProvider.dart';

class VolumeButton extends ConsumerStatefulWidget {
  const VolumeButton({super.key});

  @override
  VolumeButtonState createState() => VolumeButtonState();
}

class VolumeButtonState extends ConsumerState<VolumeButton> {

  void onTapped(){
    ref.read(showVolumeSliderProvider.notifier).state = 
    !ref.read(showVolumeSliderProvider.notifier).state;
    print(ref.read(showVolumeSliderProvider.notifier).state);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkCard(
      onTap: onTapped, 
      padding: 10,
      child: const Icon(
        Icons.volume_up,
        size: 32,
      )
    );
  }
}