import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/MyAppBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MyAppBar(
        image: AssetImage("assets/images/mp3_mode_setting.png")
      ),
      body: PageWrapper(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showLicensePage(context: context);
              },
              child: const Text("LICENCE"),
            )
          ],
        ),
      )
    );
  }
}