import 'package:musicalization/logic/permission.dart';
import 'package:musicalization/logic/startUpRepositry.dart';

class StartUp{
  final _mediaAudioRequester = MediaAudioPermissionRequester();
  final _repo = StartUpRepositry();

  void init() {
    _mediaAudioRequester.requestPermission();
    _repo.refreshData();
  }
}
