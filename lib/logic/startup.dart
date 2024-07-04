import 'package:musicalization/logic/permission.dart';
import 'package:musicalization/logic/realm/musicUpdater.dart';

class StartUp{
  final _permissionRequester = MediaAudioPermissionRequester();
  final _updater = MusicUpdater();

  void init(){
    _permissionRequester.requestPermission();
    _updater.updateDataBase();
  }
}
