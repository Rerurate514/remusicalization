import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'showPlayListImageCreater.g.dart';

@riverpod
class ShowPlayListImageCreaterNotifier extends _$ShowPlayListImageCreaterNotifier {
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
