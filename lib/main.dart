import 'package:flutter/material.dart';
import 'package:musicalization/enums/colors.dart';
import 'package:musicalization/mainDuplicater.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: ThemeData.dark().textTheme.copyWith(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: MyColors.PRIMARY_BLUE.color,
        ),
        iconTheme: IconThemeData(
          color: MyColors.PRIMARY_BLUE.color,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: MyColors.PRIMARY_BLUE.color,
        )
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context){
    return const MainDuplicater();
  }
}
