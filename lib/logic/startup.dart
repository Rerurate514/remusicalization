import 'package:musicalization/logic/permission.dart';
import 'package:musicalization/logic/startUpRepositry.dart';

class StartUp{
  final _permissionRequester = MediaAudioPermissionRequester();
  final _repo = StartUpRepositry();

  void init(){
    _permissionRequester.requestPermission();
    _repo.refreshData();
  }
}
