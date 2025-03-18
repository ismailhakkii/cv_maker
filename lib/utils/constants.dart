// utils/constants.dart
import 'package:flutter/material.dart';

// Renkler
class AppColors {
  static const Color primary = Color(0xFF2C3E50);
  static const Color secondary = Color(0xFF34495E);
  static const Color accent = Color(0xFF3498DB);
  static const Color background = Color(0xFFF9F9F9);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color divider = Color(0xFFDDDDDD);
  static const Color error = Color(0xFFE74C3C);
}

// Metinler
class AppStrings {
  static const String appName = 'CV Maker';
  static const String welcomeTitle = 'CV Maker Uygulamasına Hoş Geldiniz';
  static const String welcomeSubtitle = 'Profesyonel bir CV oluşturmak için adımları takip edin';
  static const String startButton = 'Başla';
  static const String continueButton = 'Devam Et';
  static const String saveButton = 'Kaydet';
  static const String previewButton = 'Önizleme';
  static const String saveAndShareButton = 'PDF Olarak Kaydet ve Paylaş';
  static const String templateSelectionTitle = 'Şablon Seçimi';
  static const String personalInfoTitle = 'Kişisel Bilgiler';
  static const String educationTitle = 'Eğitim Bilgileri';
  static const String workExperienceTitle = 'İş Deneyimi';
  static const String skillsTitle = 'Yetenekler';
  static const String additionalInfoTitle = 'Ek Bilgiler';
  static const String previewTitle = 'CV Önizleme';
  static const String savePdfSuccess = 'PDF kaydedildi ve paylaşıldı';
  static const String errorOccurred = 'Hata oluştu: ';
}

// Tema
class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: AppColors.cardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        filled: true,
        fillColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
      ),
    );
  }
}

// Form doğrulama metinleri
class ValidationMessages {
  static const String requiredField = 'Bu alan zorunludur';
  static const String invalidEmail = 'Geçerli bir e-posta adresi giriniz';
  static const String invalidPhone = 'Geçerli bir telefon numarası giriniz';
}

// Ekran geçişleri için yollar
class AppRoutes {
  static const String welcome = '/';
  static const String templateSelection = '/template_selection';
  static const String personalInfo = '/personal_info';
  static const String education = '/education';
  static const String workExperience = '/work_experience';
  static const String skills = '/skills';
  static const String additionalInfo = '/additional_info';
  static const String preview = '/preview';
}