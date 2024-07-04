import 'package:flutter/material.dart';
import 'package:musicalization/Widgets/InkCard.dart';

class HomeMusicList extends StatefulWidget {
  const HomeMusicList({super.key});

  @override
  _HomeMusicListState createState() => _HomeMusicListState();
}

class _HomeMusicListState extends State<HomeMusicList> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded( 
      child: ListView.builder(
        controller: _scrollController,
        itemCount: 100,
        addAutomaticKeepAlives: true,
        itemBuilder: (_, int index){
          return InkCard(
            onTap: () {}, 
            child: ListTile(
              leading: Text("leading"),
              title: Text("title"),
            )
          );
        }
      ),
    );
  }
}