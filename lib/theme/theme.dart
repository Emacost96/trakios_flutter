import 'package:flutter/material.dart';

// --- AppColors per app di gamification del turismo sostenibile ---
class AppColors {
  // Nuova palette colori basata su specifiche del cliente
  static const Color primary = Color(0xFF9DE093); // Verde principale
  static const Color secondary = Color(0xFF66B2FF); // Azzurro
  static const Color accent = Color(0xFFFFD23F); // Giallo per gamification
  static const Color warning = Color(0xFFFF6B6B); // Rosso per avvisi
  static const Color success = Color(0xFF9DE093); // Verde per successi
  static const Color darkGreen = Color(0xFF344E41); // Verde scuro
  static const Color lightGray = Color(0xFFF7F7F7); // Grigio chiaro

  // Colori Tema Scuro - Adattati alla nuova palette
  static const Color darkText = Color(0xFFF7F7F7); // Grigio chiaro per testo
  static const Color darkTitle = Color(0xFFFFFFFF); // Bianco puro per titoli
  static const Color darkBackground = Color(0xFF344E41); // Verde scuro come sfondo
  static const Color darkNavBackground = Color(0xFF2A3B2E); // Verde ancora più scuro per nav
  static const Color darkIconColor = Color(0xFF9DE093); // Verde chiaro per icone
  static const Color darkUiBackground = Color(0xFF3F5244); // Verde scuro per UI
  static const Color darkCardBackground = Color(0xFF495750); // Verde medio per card
  static const Color darkAccent = Color(0xFF66B2FF); // Azzurro per accenti dark

  // Colori Tema Chiaro - Adattati alla nuova palette
  static const Color lightText = Color(0xFF344E41); // Verde scuro per leggibilità
  static const Color lightTitle = Color(0xFF344E41); // Verde scuro per titoli
  static const Color lightBackground = Color(0xFFF7F7F7); // Grigio chiaro sfondo
  static const Color lightNavBackground = Color(0xFFFFFFFF); // Bianco per navigazione
  static const Color lightIconColor = Color(0xFF9DE093); // Verde per icone
  static const Color lightUiBackground = Color(0xFFFFFFFF); // Bianco per UI
  static const Color lightCardBackground = Color(0xFFFFFFFF); // Bianco per card
  static const Color lightAccent = Color(0xFF66B2FF); // Azzurro per accenti
}

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary, // Verde sostenibile
      onPrimary: Colors.white,
      secondary: AppColors.secondary, // Blu natura
      onSecondary: Colors.white,
      tertiary: AppColors.accent, // Arancione gamification
      onTertiary: Colors.white,
      error: AppColors.warning,
      onError: Colors.white,
      surface: AppColors.lightUiBackground,
      onSurface: AppColors.lightText,
      surfaceContainerHighest: AppColors.lightCardBackground,
      outline: AppColors.lightIconColor.withValues(alpha: 0.3),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightNavBackground,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.lightTitle,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      iconTheme: IconThemeData(color: AppColors.lightIconColor),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightNavBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightIconColor,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    cardTheme: CardThemeData(
      color: AppColors.lightCardBackground,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
      elevation: 6,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: ColorScheme.dark(
      primary: AppColors.darkAccent, // Verde chiaro per dark mode
      onPrimary: AppColors.darkBackground,
      secondary: AppColors.secondary,
      onSecondary: Colors.white,
      tertiary: AppColors.accent, // Giallo per achievements
      onTertiary: AppColors.darkBackground,
      error: AppColors.warning,
      onError: Colors.white,
      surface: AppColors.darkUiBackground,
      onSurface: AppColors.darkText,
      surfaceContainerHighest: AppColors.darkCardBackground,
      outline: AppColors.darkIconColor.withValues(alpha: 0.3),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkNavBackground,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: AppColors.darkTitle,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
      iconTheme: IconThemeData(color: AppColors.darkIconColor),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkNavBackground,
      selectedItemColor: AppColors.darkAccent,
      unselectedItemColor: AppColors.darkIconColor,
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    cardTheme: CardThemeData(
      color: AppColors.darkCardBackground,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkAccent,
        foregroundColor: AppColors.darkBackground,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.darkBackground,
      elevation: 6,
    ),
  );
}
