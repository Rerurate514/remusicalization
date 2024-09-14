import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/providers/isPlayListSelectedProvider.dart';

class ReturnButtonFromMusic extends ConsumerStatefulWidget {
  const ReturnButtonFromMusic({super.key});

  @override
  ReturnButtonFromMusicState createState() => ReturnButtonFromMusicState();
} 

class ReturnButtonFromMusicState extends ConsumerState<ReturnButtonFromMusic>{
  void returnPlayListPage(){
    ref.watch(isPlayListSelectedProvider.notifier).state = false;
  }
  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: returnPlayListPage,
      child: const Icon(Icons.back_hand),
    );
  }
}
