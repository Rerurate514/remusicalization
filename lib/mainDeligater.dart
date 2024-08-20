import 'package:flutter/material.dart';
import 'package:musicalization/logic/startup.dart';
import 'package:musicalization/pages/HomePage.dart';
import 'package:musicalization/pages/ListPage.dart';
import 'package:musicalization/pages/PlayPage.dart';
import 'package:musicalization/pages/SettingPage.dart';

class MainDeligater extends StatefulWidget {
  const MainDeligater({super.key});

  @override
  _MainDeligaterState createState() => _MainDeligaterState();
}

class _MainDeligaterState extends State<MainDeligater> {
  final PageController _pageController = PageController(initialPage: 0);

  final List<Widget> _pages = const [
    HomePage(),
    ListPage(),
    PlayPage(),
    SettingPage()
  ];

  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    StartUp().init();
  }

  
  void _onItemTapped(int indexArg) {
    setState(() {
      _currentPageIndex = indexArg;
      _pageController.animateToPage(
        indexArg,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: _pages,
        ),
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