import 'package:flutter/material.dart';

class AppColors {
  // Couleurs principales - Thème sombre avec bleu foncé
  static const Color primary = Color(0xFF1E3A8A); // Bleu foncé principal
  static const Color primaryDark = Color(0xFF1E2A5A); // Bleu très foncé
  static const Color primaryLight = Color(0xFF3B82F6); // Bleu plus clair
  
  // Couleurs secondaires motivantes
  static const Color secondary = Color(0xFF10B981); // Vert émeraude énergisant
  static const Color accent = Color(0xFF8B5CF6); // Violet vibrant
  static const Color warning = Color(0xFFF59E0B); // Orange doré
  static const Color success = Color(0xFF059669); // Vert succès
  static const Color error = Color(0xFFDC2626); // Rouge d'erreur
  
  // Couleurs de fond sombres
  static const Color background = Color(0xFF0F172A); // Fond très sombre
  static const Color surface = Color(0xFF1E293B); // Surface sombre
  static const Color surfaceVariant = Color(0xFF334155); // Surface alternative
  static const Color onSurface = Color(0xFFF1F5F9); // Texte sur surface
  static const Color onPrimary = Color(0xFFFFFFFF); // Texte sur primaire
  
  // Couleurs de texte pour thème sombre
  static const Color textPrimary = Color(0xFFF8FAFC); // Texte principal clair
  static const Color textSecondary = Color(0xFFCBD5E1); // Texte secondaire
  static const Color textLight = Color(0xFF94A3B8); // Texte atténué
  static const Color textDisabled = Color(0xFF64748B); // Texte désactivé
  
  // Couleurs d'accent motivantes
  static const Color energyBlue = Color(0xFF0EA5E9); // Bleu énergisant
  static const Color motivatingPurple = Color(0xFF7C3AED); // Violet motivant
  static const Color inspiringGreen = Color(0xFF22C55E); // Vert inspirant
  static const Color warmOrange = Color(0xFFEA580C); // Orange chaleureux
  
  // Gradients pour thème sombre
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );
  
  static const LinearGradient motivationalGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [energyBlue, motivatingPurple],
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryDark, background],
    stops: [0.0, 0.4],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surface, surfaceVariant],
  );
}

class AppTextStyles {
  // Styles de texte adaptés au thème sombre
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textLight,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textLight,
  );
  
  // Styles spéciaux pour le thème sombre
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: AppColors.onPrimary,
  );
  
  static const TextStyle accentText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.energyBlue,
  );
}

class AppDimensions {
  // Espacement
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  
  // Rayons de bordure
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 20.0;
  static const double radiusXLarge = 24.0;
  static const double radiusCircular = 50.0;
  
  // Élévations pour le thème sombre
  static const double elevationSmall = 4.0;
  static const double elevationMedium = 8.0;
  static const double elevationLarge = 12.0;
  static const double elevationXLarge = 16.0;
  
  // Tailles d'icônes
  static const double iconSmall = 20.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXLarge = 48.0;
}

// Classe pour créer le ThemeData complet
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryDark,
        secondary: AppColors.secondary,
        secondaryContainer: AppColors.accent,
        background: AppColors.background,
        surface: AppColors.surface,
        surfaceVariant: AppColors.surfaceVariant,
        onPrimary: AppColors.onPrimary,
        onSecondary: Colors.white,
        onBackground: AppColors.textPrimary,
        onSurface: AppColors.onSurface,
        error: AppColors.error,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: AppDimensions.elevationSmall,
        centerTitle: true,
        titleTextStyle: AppTextStyles.heading2,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.energyBlue,
        unselectedItemColor: AppColors.textLight,
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevationMedium,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: AppDimensions.elevationSmall,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          elevation: AppDimensions.elevationSmall,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingLarge,
            vertical: AppDimensions.paddingMedium,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: AppTextStyles.buttonText,
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.heading1,
        headlineMedium: AppTextStyles.heading2,
        titleMedium: AppTextStyles.subtitle,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.bodySmall,
        bodySmall: AppTextStyles.caption,
      ),
    );
  }
}
