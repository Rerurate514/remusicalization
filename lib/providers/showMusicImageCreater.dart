import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'showMusicImageCreater.g.dart';

@riverpod
class ShowMusicImageCreaterNotifier extends _$ShowMusicImageCreaterNotifier {
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
