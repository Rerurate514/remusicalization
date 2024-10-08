

// ignore: must_be_immutable
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/logic/imagePicker.dart';
import 'package:musicalization/logic/musicPlayer.dart';
import 'package:musicalization/logic/pictureBinaryConverter.dart';
import 'package:musicalization/logic/realm/realmIOManager.dart';
import 'package:musicalization/models/schema.dart';
import 'package:musicalization/providers/musicImageProvider.dart';

class MusicImageCreater extends ConsumerStatefulWidget {
  final Function() closeFragment;
  const MusicImageCreater({super.key, required this.closeFragment});

  @override
  MusicImageCreaterState createState() => MusicImageCreaterState();
}

class MusicImageCreaterState extends ConsumerState<MusicImageCreater> {
  final PictureBinaryConverter _converter = PictureBinaryConverter();
  final RealmIOManager _ioManager = RealmIOManager(Music.schema);
  final MusicPlayer _player = MusicPlayer.getEmptyInstance();

  Matrix4 _transform = Matrix4.identity();

  final GlobalKey _globalKey = GlobalKey();
  Uint8List? _imageData;

  final ImagePickerController _picker = ImagePickerController();

  String _selectedPath = "";

  void _selectFile() async {
    XFile? file = await _picker.getImageFromGarally();
    setState(() {
      _selectedPath = file?.path ?? "";
    });
  }

  Future<void> _captureImage() async {
    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    String imageDataBinary = await _converter.convertBoundaryToImageBase64(boundary);
    await _updatePicture(imageDataBinary);
    _setImageToMusic(imageDataBinary);
  }

  Future<void> _updatePicture(String newPictureBinary) async {
    final Music info = Music(
      _player.currentMusic.id, 
      _player.currentMusic.name,
      _player.currentMusic.path,
      _player.currentMusic.volume, 
      _player.currentMusic.lyrics, 
      newPictureBinary
    );
    _ioManager.edit(newData: info);
  }

  void _setImageToMusic(String newPictureBinary){
    ImageProvider imageProvider = _converter.convertBase64ToImage(newPictureBinary);
    ref.read(musicImageProvider.notifier).state = imageProvider;
  }

  void _initMatrix(){
    setState(() {
      _transform = Matrix4.identity();
    });
  }
  
  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.2),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              const StandardSpace(),
              buildHeader(),
              const StandardSpace(),
              buildMatrix(size),
              const StandardSpace(),
              buildBtns(),
              const StandardSpace(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(){
    return const Text("イメージ画像の作成");
  }

  Widget buildMatrix(Size size){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1000)
      ),
      child: SizedBox(
        width: size.width * 0.74,
        height: size.height * 0.34,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(1000),
          child: RepaintBoundary(
            key: _globalKey,
            child: buildPicture(),
          ),
        ),
      )
    );
  }

  
  Widget buildPicture(){
    return MatrixGestureDetector(
      onMatrixUpdate: (matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix) {
        setState(() {
          _transform = matrix;
        });
      },
      child: Transform(
        transform: _transform,
        child: _selectedPath != ""
          ? Image.file(File(_selectedPath))
          : const SizedBox(height: 10,width: 10),
      ),
    );
  }

  Widget buildBtns(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkCard(
          padding: 16,
          onTap: widget.closeFragment, 
          child: const Icon(
            Icons.arrow_back,
            size: 32,
          )
        ),
        InkCard(
          padding: 16,
          onTap: _selectFile, 
          child: const Icon(
            Icons.download,
            size: 32,
          )
        ),
        InkCard(
          padding: 16,
          onTap: _initMatrix, 
          child: const Icon(
            Icons.update_rounded,
            size: 32,
          )
        ),
        InkCard(
          padding: 16,
          onTap: () {
            _captureImage();
            widget.closeFragment();
          }, 
          child: const Icon(
            Icons.check,
            size: 32,
          )
        ),
      ],
    );
  }
}
