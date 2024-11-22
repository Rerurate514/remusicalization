import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/MyAppBar.dart';
import 'package:musicalization/Widgets/PageWrapper.dart';
import 'package:musicalization/components/ListPage/bottomListNameShower.dart';
import 'package:musicalization/components/ListPage/listPageDeligater.dart';
import 'package:musicalization/components/ListPage/returnButtonFromMusic.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return const Scaffold(
      appBar: MyAppBar(
        image: AssetImage("assets/images/mp3_mode_list.png")
      ),
      body: PageWrapper(
        child: ListPageDeligater() 
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ReturnButtonFromMusic(),
          BottomListNameShower(),
        ],
      )
    );
  }
}
