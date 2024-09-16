import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/providers/musicListInPlayListProvider.dart';

class BottomListNameShower extends ConsumerStatefulWidget {
  const BottomListNameShower({super.key});

  @override
  BottomListNameShowerState createState() => BottomListNameShowerState();
}

class BottomListNameShowerState extends ConsumerState<BottomListNameShower> {
  @override
  Widget build(BuildContext context){
    final prov = ref.watch(musicListInPlayListProvider);
    return prov != null
    ? Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(prov.name),
      )
    )
    : const SizedBox.shrink();
  }
}
