import 'package:flutter/material.dart';

enum MyColors{
  PRIMARY_BLUE,
  UNSELECTED_BLUE
}

extension ColorEx on MyColors{
  Color get color {
    switch(this){
      case MyColors.PRIMARY_BLUE: return const Color.fromARGB(255, 44, 232, 245);
      case MyColors.UNSELECTED_BLUE: return const Color.fromARGB(255, 14, 68, 71);
    }
  }
}
