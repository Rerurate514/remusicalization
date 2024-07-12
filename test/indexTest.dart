import 'package:flutter_test/flutter_test.dart';
import 'package:musicalization/models/index.dart';

void main(){
  final list = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

  test("index-inc", (){
    Index index = Index(list: list);

    index.increase();
    expect(list[index.value], "1");

    index.setIndex(9);
    index.increase();
    expect(list[index.value], "0");
  });

  test("index-disc", (){
    Index index = Index(list: list);

    index.dicrease();
    expect(list[index.value], "9");
  });
}
