import 'package:flutter/widgets.dart';
import 'package:musicalization/settings/globalNavigatorKey.dart';

double getImageAvatorSize(){
  final Size size = MediaQuery.of(navigatorKey.currentContext!).size;
  
  if(size.height < 800){
    return size.height * 0.2;
  }
  
  return size.height * 0.35;
}
