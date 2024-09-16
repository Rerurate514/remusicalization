
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/components/ListPage/choiceMusic.dart';
import 'package:musicalization/components/ListPage/choicePlayList.dart';
import 'package:musicalization/providers/isPlayListSelectedProvider.dart';
import 'package:musicalization/providers/musicListInPlayListProvider.dart';

class ListPageDeligater extends ConsumerStatefulWidget {
  const ListPageDeligater({super.key});

  @override
  ListPageDeligaterState createState() => ListPageDeligaterState();
}

class ListPageDeligaterState extends ConsumerState<ListPageDeligater>{
  @override
  Widget build(BuildContext context){
    final isPlayListSelected = ref.watch(isPlayListSelectedProvider);
    final wrappedMusicList = ref.watch(musicListInPlayListProvider.notifier).state;
    
    return isPlayListSelected
    ? ChoiceMusic(list: wrappedMusicList!.musicList)
    : const ChoicePlayList();
  }
}
