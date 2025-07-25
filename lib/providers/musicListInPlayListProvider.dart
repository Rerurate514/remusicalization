import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/models/wrappedPlayList.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'musicListInPlayListProvider.g.dart';

@riverpod
class MusicListInPlayListNotifier extends _$MusicListInPlayListNotifier {
  @override
  WrappedPlayList? build() {
    return null;
  }

  void init(){
    state = null;
  }

  void update(WrappedPlayList wrappedPlayList){
    state = wrappedPlayList;
  }
}
