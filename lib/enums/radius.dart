import 'package:flutter/material.dart';

enum MyBorderRadius{
  CARD
}

extension RadiusEx on MyBorderRadius {
  BorderRadius get value {
    switch(this){
      case MyBorderRadius.CARD: return const BorderRadius.all(
        Radius.circular(16)
      );
    }
  }
}
