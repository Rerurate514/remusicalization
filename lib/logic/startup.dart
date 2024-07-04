import 'package:musicalization/logic/permission.dart';

class StartUp{
  final _permissionRequester = MediaAudioPermissionRequester();
  
  void init(){
    _permissionRequester.requestPermission();
  }
}
