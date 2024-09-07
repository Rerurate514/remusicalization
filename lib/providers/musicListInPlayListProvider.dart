import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicalization/models/schema.dart';

final musicListInPlayListProvider = StateProvider<List<Music>>((ref) => []);
