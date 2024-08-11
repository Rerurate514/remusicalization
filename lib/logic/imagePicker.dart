import 'package:image_picker/image_picker.dart';

class ImagePickerController{
  final _imagePicker = ImagePicker();

  Future<XFile?> getImageFromGarally() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }
}
