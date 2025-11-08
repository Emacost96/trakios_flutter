import 'package:go_router/go_router.dart';

import 'package:trakios/screens/map/map.dart';
import 'package:trakios/screens/missions/missions.dart';
import 'package:trakios/screens/profile/profile.dart';
import 'package:trakios/widgets/scaffold_with_navbar.dart';

final router = GoRouter(
  initialLocation: '/map', // Imposta la pagina iniziale
  routes: [
    ShellRoute(
      // Il builder costruisce il widget persistente (il nostro ScaffoldWithNavBar)
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        // Rotta per la Mappa
        GoRoute(path: '/map', builder: (context, state) => MapScreen()),
        // Rotta per le Impostazioni
        GoRoute(
          path: '/missions',
          // **NOTA:** Devi creare questo widget
          builder: (context, state) => Missions(),
        ),
        // Rotta per il Profilo
        GoRoute(
          path: '/profile',
          // **NOTA:** Devi creare questo widget
          builder: (context, state) => Profile(),
        ),
      ],
    ),
  ],
);
