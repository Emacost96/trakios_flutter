import 'package:go_router/go_router.dart';
import 'package:trakios/screens/map/map.dart';

final router = GoRouter(
  routes: [GoRoute(path: '/', builder: (context, state) => MapScreen())],
);
