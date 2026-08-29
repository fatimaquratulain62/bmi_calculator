// /// Central place for all app-wide constants.
// class AppConstants {
//   AppConstants._();

//   static const String appName = 'BMI Calculator';
//   static const String appVersion = '1.0.0';
//   static const String privacyPolicyUrl = 'https://example.com/privacy';
//   static const String playStoreUrl =
//       'https://play.google.com/store/apps/details?id=com.example.bmi_calculator';

//   // SharedPreferences keys
//   static const String prefThemeMode = 'theme_mode';
//   static const String prefBmiHistory = 'bmi_history';
//   static const String prefHeightUnit = 'height_unit';
//   static const String prefWeightUnit = 'weight_unit';

//   // BMI thresholds
//   static const double bmiUnderweightMax = 18.5;
//   static const double bmiNormalMax = 24.9;
//   static const double bmiOverweightMax = 29.9;

//   // Validation limits
//   static const double minHeightCm = 50.0;
//   static const double maxHeightCm = 300.0;
//   static const double minWeightKg = 2.0;
//   static const double maxWeightKg = 500.0;

//   // Unit conversion
//   static const double cmPerInch = 2.54;
//   static const double kgPerLb = 0.453592;
//   static const double inchesPerFoot = 12.0;
// }

// /// Height units supported by the app.
// enum HeightUnit {
//   cm,
//   feetInches;

//   String get label {
//     switch (this) {
//       case HeightUnit.cm:
//         return 'cm';
//       case HeightUnit.feetInches:
//         return 'ft / in';
//     }
//   }
// }

// /// Weight units supported by the app.
// enum WeightUnit {
//   kg,
//   lbs;

//   String get label {
//     switch (this) {
//       case WeightUnit.kg:
//         return 'kg';
//       case WeightUnit.lbs:
//         return 'lbs';
//     }
//   }
// }

// /// App theme options.
// enum AppThemeMode {
//   system,
//   light,
//   dark;

//   String get label {
//     switch (this) {
//       case AppThemeMode.system:
//         return 'System Default';
//       case AppThemeMode.light:
//         return 'Light';
//       case AppThemeMode.dark:
//         return 'Dark';
//     }
//   }
// }



/// Central place for all app-wide constants.
class AppConstants {
  AppConstants._();

  static const String appName = 'BMI Calculator';
  static const String appVersion = '1.0.0';

  /// The real Android application ID declared in android/app/build.gradle.
  /// Update this if you change the applicationId before publishing.
  static const String applicationId = 'com.example.bmi_calculator';

  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=$applicationId';

  static const String shareText =
      'Check out BMI Calculator – a free app to track your Body Mass Index '
      'and stay on top of your health!\n\n$playStoreUrl';

  // SharedPreferences keys
  static const String prefThemeMode = 'theme_mode';
  static const String prefBmiHistory = 'bmi_history';
  static const String prefHeightUnit = 'height_unit';
  static const String prefWeightUnit = 'weight_unit';

  // BMI thresholds
  static const double bmiUnderweightMax = 18.5;
  static const double bmiNormalMax = 24.9;
  static const double bmiOverweightMax = 29.9;

  // Validation limits
  static const double minHeightCm = 50.0;
  static const double maxHeightCm = 300.0;
  static const double minWeightKg = 2.0;
  static const double maxWeightKg = 500.0;

  // Unit conversion
  static const double cmPerInch = 2.54;
  static const double kgPerLb = 0.453592;
  static const double inchesPerFoot = 12.0;
}

/// Height units supported by the app.
enum HeightUnit {
  cm,
  feetInches;

  String get label {
    switch (this) {
      case HeightUnit.cm:
        return 'cm';
      case HeightUnit.feetInches:
        return 'ft / in';
    }
  }
}

/// Weight units supported by the app.
enum WeightUnit {
  kg,
  lbs;

  String get label {
    switch (this) {
      case WeightUnit.kg:
        return 'kg';
      case WeightUnit.lbs:
        return 'lbs';
    }
  }
}

/// App theme options.
enum AppThemeMode {
  system,
  light,
  dark;

  String get label {
    switch (this) {
      case AppThemeMode.system:
        return 'System Default';
      case AppThemeMode.light:
        return 'Light';
      case AppThemeMode.dark:
        return 'Dark';
    }
  }
}
