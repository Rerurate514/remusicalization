import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'showVolumeSliderProvider.g.dart';

@riverpod
class ShowVolumeSliderNotifier extends _$ShowVolumeSliderNotifier {
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
