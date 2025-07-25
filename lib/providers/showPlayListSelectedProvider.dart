
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

//final isPlayListSelectedProvider = StateProvider((ref) => false);

part 'showPlayListSelectedProvider.g.dart';

@riverpod
class ShowPlayListSelectedNotifier extends _$ShowPlayListSelectedNotifier {
  @override
  bool build() {
    return false;
  }

  void toggleVisible(){
    state = !state;
  }
  
  void show() {
    state = true;
  }
  
  void hide() {
    state = false;
  }
}
