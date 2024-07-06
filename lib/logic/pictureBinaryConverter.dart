import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

class PictureBinaryConverter{
  Future<String> convertBoundaryToImageBase64(RenderRepaintBoundary boundary) async {
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List imageData = byteData!.buffer.asUint8List();
    String imageDataBinary = base64Encode(imageData);
    return imageDataBinary;
  }

  ImageProvider convertBase64ToImage(String base64) {
    Uint8List bytes = base64Decode(base64.split(',').last);
    ImageProvider imageProvider = Image.memory(bytes).image;
    return imageProvider;
  }
}