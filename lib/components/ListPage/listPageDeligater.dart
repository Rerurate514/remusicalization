
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/components/ListPage/choiceMusic.dart';
import 'package:musicalization/components/ListPage/choicePlayList.dart';
import 'package:musicalization/providers/isPlayListSelectedProvider.dart';

class ListPageDeligater extends ConsumerStatefulWidget {
  const ListPageDeligater({super.key});

  @override
  ListPageDeligaterState createState() => ListPageDeligaterState();
}

class ListPageDeligaterState extends ConsumerState<ListPageDeligater>{
  @override
  Widget build(BuildContext context){
    final isPlayListSelected = ref.watch(isPlayListSelectedProvider);
    return isPlayListSelected
    ? const ChoiceMusic()
    : const ChoicePlayList();
  }
}
