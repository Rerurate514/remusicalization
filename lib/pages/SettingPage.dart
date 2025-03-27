import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';
import 'package:musicalization/Widgets/MyAppBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/logic/permission.dart';
import 'package:musicalization/utils/showSuccessDialog.dart';
import 'package:musicalization/utils/showWarnDialog.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        image: AssetImage("assets/images/mp3_mode_setting.png")
      ),
      body: PageWrapper(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLicenceCard(),
            _buildPermissionRequestButton()
          ],
        ),
      )
    );
  }

  Widget _buildLicenceCard(){
    return InkCard(
      padding: 10,
      onTap: () {
        showLicensePage(context: context);
      },
      child: const Text("LICENCE"),
    );
  }

  Widget _buildPermissionRequestButton(){
    return InkCard(
      padding: 10,
      onTap: () async {
        final media = await MediaAudioPermissionRequester().requestPermission();
        final storage = await StorageAccessRequester().requestPermission();

        if(media.isGranted && storage.isGranted){
          showSuccessDialog("権限が全て認証されています！");
        }
        else{
          showWarnDialog("必要な権限が足りていません。");
        }
      }, 
      child: const Text("権限を承認する。")
    );
  }
}
