import 'package:flutter/material.dart';

// --- AppColors (mantenuta per riferimento) ---
class AppColors {
  static const Color primary = Color(0xFF6849a7);
  static const Color warning = Color(0xFFcc475a);

  // Colori Scuro
  static const Color darkText = Color(0xFFd4d4d4);
  static const Color darkTitle = Color(0xFFffffff);
  static const Color darkBackground = Color(0xFF252231);
  static const Color darkNavBackground = Color(0xFF201e2b);
  static const Color darkIconColor = Color(0xFF9591a5);
  static const Color darkUiBackground = Color(0xFF2f2b3d);
  static const Color darkCardBackground = Color(0xFF3d3a4a);

  // Colori Chiaro
  static const Color lightText = Color(0xFF625f72);
  static const Color lightTitle = Color(0xFF201e2b);
  static const Color lightBackground = Color(0xFFe0dfe8);
  static const Color lightNavBackground = Color(0xFFe8e7ef);
  static const Color lightIconColor = Color(0xFF686477);
  static const Color lightUiBackground = Color(0xFFd6d5e1);
  static const Color lightCardBackground = Color(0xFFE9E9E9);
}

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.darkTitle,
      secondary: AppColors.warning,
      surface: AppColors.lightUiBackground,
      onSurface: AppColors.lightText,
      error: AppColors.warning,
      surfaceContainerHighest: AppColors.lightCardBackground,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightNavBackground,
      titleTextStyle: TextStyle(
        color: AppColors.lightTitle,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.lightIconColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightNavBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightIconColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.darkTitle,
      secondary: AppColors.warning,
      surface: AppColors.darkUiBackground,
      onSurface: AppColors.darkText,
      error: AppColors.warning,
      surfaceContainerHighest: AppColors.darkCardBackground,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkNavBackground,
      titleTextStyle: TextStyle(
        color: AppColors.darkTitle,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: AppColors.darkIconColor),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkNavBackground,
      selectedItemColor: AppColors.darkTitle,
      unselectedItemColor: AppColors.darkIconColor,
    ),
  );
}
