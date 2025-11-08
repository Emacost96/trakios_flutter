import 'package:flutter/material.dart';
import 'package:trakios/theme/theme.dart';

/// Gestione centralizzata degli stili di testo.
///
/// Gli stili si adattano automaticamente in base al tema corrente
/// (light/dark) usando [Theme.of(context)].
class AppTextStyles {
  // Titoli grandi (es. pagine o sezioni)
  static TextStyle headline(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: isDark ? AppColors.darkTitle : AppColors.lightTitle,
    );
  }

  // Titoli secondari
  static TextStyle title(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: isDark ? AppColors.darkTitle : AppColors.lightTitle,
    );
  }

  // Sottotitoli
  static TextStyle subtitle(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: isDark ? AppColors.darkText : AppColors.lightText,
    );
  }

  // Testo normale
  static TextStyle body(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 16,
      color: isDark ? AppColors.darkText : AppColors.lightText,
    );
  }

  // Testo piccolo
  static TextStyle bodySmall(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 14,
      color: isDark
          ? AppColors.darkText.withOpacity(0.7)
          : AppColors.lightText.withOpacity(0.7),
    );
  }

  // Etichette o didascalie
  static TextStyle caption(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextStyle(
      fontSize: 12,
      color: isDark
          ? AppColors.darkText.withOpacity(0.6)
          : AppColors.lightText.withOpacity(0.6),
    );
  }

  // Testo nei pulsanti
  static TextStyle button(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
  }

  // Link cliccabili
  static TextStyle link(BuildContext context) {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.primary,
      decoration: TextDecoration.underline,
    );
  }
}
