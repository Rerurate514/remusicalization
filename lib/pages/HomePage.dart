import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/HeaderMenuBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/Widgets/standardSpace.dart';
import 'package:musicalization/components/HomePage/HomeMusicList.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _onUpdateBtnTapped(){

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageWrapper(
        child: Column(
          children: [
            HeaderMenuBar(
              leftWidget: const Icon(
                Icons.shuffle,
                size: 40,
              ), 
              leftWidgetTappedCallback: () {}, 
              rightWidget: const Icon(
                Icons.add_to_drive_outlined,
                size: 40,
              ), 
              rightWidgetTappedCallback: () {}
            ),
            StandardSpace(),
            const HomeMusicList()
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        onPressed: _onUpdateBtnTapped,
        child: const Icon(
          Icons.update,
          size: 32,
        ),
      ),
    );
  }
}