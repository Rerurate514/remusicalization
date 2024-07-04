import 'package:flutter/material.dart';
import 'package:musicalization/pages/HomePage.dart';
import 'package:musicalization/pages/ListPage.dart';
import 'package:musicalization/pages/PlayPage.dart';
import 'package:musicalization/pages/SettingPage.dart';

class MainDuplicater extends StatefulWidget {
  const MainDuplicater({super.key});

  @override
  _MainDuplicaterState createState() => _MainDuplicaterState();
}

class _MainDuplicaterState extends State<MainDuplicater> {
  final List<Widget> _pages = const [
    HomePage(),
    ListPage(),
    PlayPage(),
    SettingPage()
  ];

  int _currentPageIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: _pages[_currentPageIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "List"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: "Play"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Setting"
          ),
        ],
        currentIndex: _currentPageIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}