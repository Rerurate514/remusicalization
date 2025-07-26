import 'package:flutter/material.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'musicImageProvider.g.dart';

@riverpod
class MusicImageNotifier extends _$MusicImageNotifier {
  final PictureBinaryConverter _converter = PictureBinaryConverter();

  @override
  ImageProvider? build() {
    ref.keepAlive();
    return null;
  }

  void init(){
    state = null;
  }

  void update(String base64){
    if(base64 == "") return;
    ImageProvider imageProvider = _converter.convertBase64ToImage(base64);
    state = imageProvider;
  }
}
