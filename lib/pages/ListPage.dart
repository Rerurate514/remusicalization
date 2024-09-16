import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/MyAppBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/components/ListPage/bottomListNameShower.dart';
import 'package:musicalization/components/ListPage/listPageDeligater.dart';
import 'package:musicalization/components/ListPage/returnButtonFromMusic.dart';
import 'package:musicalization/enums/colors.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  void _onUpdateBtnTapped(){

  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MyAppBar(
        image: AssetImage("assets/images/mp3_mode_list.png")
      ),
      body: const PageWrapper(
        child: ListPageDeligater() 
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const ReturnButtonFromMusic(),
          const BottomListNameShower(),
          FloatingActionButton(
            backgroundColor: MyColors.CARD_BACKGROUND.color,
            onPressed: _onUpdateBtnTapped,
            child: const Icon(
              Icons.update,
              size: 32,
            ),
          ),
        ],
      )
    );
  }
}
