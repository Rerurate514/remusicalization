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
    final prov = ref.watch(isPlayListSelectedProvider);
    return prov
    ? FloatingActionButton(
      backgroundColor: Theme.of(context).cardColor,
      onPressed: returnPlayListPage,
      child: const Icon(Icons.arrow_back),
    )
    : const SizedBox.shrink();
  }
}
