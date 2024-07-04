import 'package:flutter/material.dart';
import 'package:musicalization/enums/colors.dart';

final ThemeData APP_THEME_DATA = ThemeData.dark().copyWith(
  textTheme: ThemeData.dark().textTheme.copyWith(),
  // colorScheme: ColorScheme.fromSeed(
  //   seedColor: MyColors.PRIMARY_BLUE.color,
  // ),
  cardTheme: CardTheme(
    color: MyColors.CARD_BACKGROUND.color,
    elevation: 8
  ),
  iconTheme: IconThemeData(
    color: MyColors.PRIMARY_BLUE.color,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: MyColors.PRIMARY_BLUE.color,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: MyColors.PRIMARY_BLUE.color,
    unselectedItemColor: MyColors.UNSELECTED_BLUE.color
  )
);
