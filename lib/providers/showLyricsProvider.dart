import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'showLyricsProvider.g.dart';

@riverpod
class ShowLyricsNotifier extends _$ShowLyricsNotifier {
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
