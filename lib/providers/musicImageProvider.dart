import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'musicImageProvider.g.dart';

@riverpod
class MusicImageNotifier extends _$MusicImageNotifier {
  @override
  ImageProvider? build() {
    return null;
  }

  void init(){
    state = null;
  }

  void update(ImageProvider? imageProvider){
    state = imageProvider;
  }
}
