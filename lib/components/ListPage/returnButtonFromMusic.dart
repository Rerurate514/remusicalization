import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/enums/colors.dart';
import 'package:musicalization/providers/isPlayListSelectedProvider.dart';
import 'package:musicalization/providers/musicListInPlayListProvider.dart';

class ReturnButtonFromMusic extends ConsumerStatefulWidget {
  const ReturnButtonFromMusic({super.key});

  @override
  ReturnButtonFromMusicState createState() => ReturnButtonFromMusicState();
} 

class ReturnButtonFromMusicState extends ConsumerState<ReturnButtonFromMusic>{
  void returnPlayListPage(){
    ref.watch(isPlayListSelectedProvider.notifier).state = false;
    ref.watch(musicListInPlayListProvider.notifier).state = null;
  }
  
  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(isPlayListSelectedProvider);
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(left: size.width * 0.06),
      child: prov
        ? FloatingActionButton(
          backgroundColor: MyColors.CARD_BACKGROUND.color,
          onPressed: returnPlayListPage,
          child: const Icon(Icons.arrow_back),
        )
        : const SizedBox.shrink(),
    );
  }
}
