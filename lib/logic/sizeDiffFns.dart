import 'package:flutter/widgets.dart';
import 'package:musicalization/settings/globalNavigatorKey.dart';

double getImageAvatorSize(){
  final Size size = MediaQuery.of(navigatorKey.currentContext!).size;
  
  if(size.height < 800){
    return size.height * 0.2;
  }
  
  return size.height * 0.35;
}

double getButtonsSize(){
  final Size size = MediaQuery.of(navigatorKey.currentContext!).size;

    if(size.height < 800){
    return 25;
  }
  
  return 32;
}

double getDownloadPadding(){
    final Size size = MediaQuery.of(navigatorKey.currentContext!).size;

    if(size.height < 800){
    return 8.0;
  }
  
  return 16.0;
}
