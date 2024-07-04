import 'package:musicalization/utils/showWarnDialog.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionRequester {
  Future<PermissionStatus> requestPermission();
}

class MediaAudioPermissionRequester extends PermissionRequester {
  @override
  Future<PermissionStatus> requestPermission() async {
    PermissionStatus status = await Permission.audio.request();

    status.isGranted
        ? print('READ_MEDIA_AUDIO permission granted.')
        : showWarnDialog("READ_MEDIA_AUDIO permission denied.");

    return status;
  }
}
