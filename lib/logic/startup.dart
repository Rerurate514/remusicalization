import 'package:musicalization/logic/permission.dart';
import 'package:musicalization/logic/realm/realmUpdater.dart';

class StartUp{
  final _mediaAudioRequester = MediaAudioPermissionRequester();
  final _updater = Updater();

  void init() async {
    await _mediaAudioRequester.requestPermission();
    _refreshData();
  }


  void _refreshData() async {
    await _updater.update();
  } 
}
