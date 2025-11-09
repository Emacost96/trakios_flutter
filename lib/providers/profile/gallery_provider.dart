import 'package:flutter_riverpod/legacy.dart';
import 'package:trakios/assets/user.dart';

final galleryProvider = StateProvider<List<String>>(
  (ref) => user['recentMemories'],
);
