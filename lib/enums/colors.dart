import 'package:flutter/material.dart';

enum MyColors{
  PRIMARY_BLUE,
  UNSELECTED_BLUE,
  CARD_BACKGROUND
}

extension ColorEx on MyColors{
  Color get color {
    switch(this){
      case MyColors.PRIMARY_BLUE: return const Color.fromARGB(255, 44, 232, 245);
      case MyColors.UNSELECTED_BLUE: return Color.fromARGB(255, 22, 103, 107);
      case MyColors.CARD_BACKGROUND: return const Color.fromARGB(255, 51, 51, 51); 
    }
  }
}
