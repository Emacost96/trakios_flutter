import 'package:flutter_riverpod/legacy.dart';
import 'package:trakios/assets/user.dart';

final tokenBalanceProvider = StateProvider<int>(
  (ref) => user['tokenBalance'],
);