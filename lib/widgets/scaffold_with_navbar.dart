import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration.uri.toString();
    int currentIndex = _calculateSelectedIndex(currentPath);

    return Scaffold(
      body: child, // La schermata specifica viene mostrata qui
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onItemTapped(context, index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 11,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.flag), label: 'Missions'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Logica per determinare l'indice basato sulla route corrente
  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/map')) {
      return 0;
    }
    if (location.startsWith('/missions')) {
      return 1;
    }
    if (location.startsWith('/profile')) {
      return 2;
    }
    return 0; // Default alla prima pagina
  }

  // Logica per navigare quando un elemento viene toccato
  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/map');
        break;
      case 1:
        context.go('/missions');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }
}
