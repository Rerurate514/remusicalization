import 'dart:io';

import 'package:musicalization/utils/getMusicDir.dart';
import 'package:musicalization/utils/showWarnDialog.dart';

///WindowsならC:User/user/Music以下
///Androidなら/storage/emulated/0/Download/以下

Future<Directory> fetchNowOSDownloadsDirectory() async {
    Directory? directory = Directory("");

    if(Platform.isWindows){
      directory = Directory(await getMusicPath());
    }
    else if(Platform.isAndroid){
      directory = Directory("/storage/emulated/0/Download/");
    }
    else if(Platform.isIOS){
      //todo
    }
    else{
      showWarnDialog("Unknown platform, Undefined logic");
    }

    return directory;
}
