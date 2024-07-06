import 'package:musicalization/models/schema.dart';

extension ListMusicEx on List<Music>{
  List<String> getNamesFromMusic(){
    return map((music) => music.name).toList();
  }
}
