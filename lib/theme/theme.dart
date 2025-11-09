import 'package:flutter/material.dart';

// --- AppColors per app di gamification del turismo sostenibile ---
class AppColors {
  // Colori principali - Verde e blu pastello sostenibili
  static const Color primary = Color(0xFF81C784); // Verde pastello naturale
  static const Color secondary = Color(0xFF81D4FA); // Blu cielo pastello
  static const Color accent = Color(0xFFFFCC80); // Arancione pastello per gamification
  static const Color warning = Color(0xFFFFAB91); // Corallo pastello per avvisi
  static const Color success = Color(0xFFA5D6A7); // Verde menta per successi
  static const Color ecoGold = Color(0xFFFFF59D); // Giallo pastello per achievements

  // Colori Tema Scuro - Atmosfera notturna con pastelli soft
  static const Color darkText = Color(0xFFE1F5FE); // Azzurro chiarissimo per testo
  static const Color darkTitle = Color(0xFFFFFFFF); // Bianco puro per titoli
  static const Color darkBackground = Color(0xFF1A2332); // Blu-grigio scuro soft
  static const Color darkNavBackground = Color(0xFF263238); // Blu-grigio navigazione
  static const Color darkIconColor = Color(0xFF80CBC4); // Verde-azzurro pastello
  static const Color darkUiBackground = Color(0xFF37474F); // Grigio-blu per UI
  static const Color darkCardBackground = Color(0xFF455A64); // Grigio-blu per card
  static const Color darkAccent = Color(0xFF80CBC4); // Teal pastello per dark mode

  // Colori Tema Chiaro - Atmosfera pastello naturale
  static const Color lightText = Color(0xFF455A64); // Grigio-blu scuro per leggibilità
  static const Color lightTitle = Color(0xFF263238); // Grigio-blu molto scuro per titoli
  static const Color lightBackground = Color(0xFFF3F8FB); // Azzurro chiarissimo
  static const Color lightNavBackground = Color(0xFFE8F4F8); // Verde-azzurro chiarissimo
  static const Color lightIconColor = Color(0xFF66BB6A); // Verde pastello per icone
  static const Color lightUiBackground = Color(0xFFE1F5FE); // Azzurro pastello UI
  static const Color lightCardBackground = Color(0xFFFFFFFF); // Bianco puro per card
  static const Color lightAccent = Color(0xFF4DB6AC); // Teal pastello per accenti
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
      tertiary: AppColors.ecoGold, // Oro per achievements
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
      backgroundColor: AppColors.ecoGold,
      foregroundColor: AppColors.darkBackground,
      elevation: 6,
    ),
  );
}
