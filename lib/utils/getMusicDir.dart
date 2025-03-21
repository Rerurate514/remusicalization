import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getMusicPath() async {
  final homeDir = join(
      (await getApplicationDocumentsDirectory())
          .path
          .replaceAll("\\Documents", ""),
      'Music');
  return homeDir;
}
