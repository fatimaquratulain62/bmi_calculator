# BMI Calculator

A production-ready Flutter BMI Calculator app built with Material Design 3, Provider state management, and clean architecture.

---

## Features

- **BMI Calculation** — cm/kg or ft-in/lbs unit switching
- **Health insights** — Category badge, recommendation, healthy weight range
- **Animated gauge** — Custom-painted semi-circular BMI arc
- **History** — Swipe-to-delete, bulk clear, persisted with SharedPreferences
- **Dark Mode** — Light / Dark / System, persisted across launches
- **Input validation** — Empty, zero, negative, and out-of-range guards
- **Responsive** — Works on phones and tablets
- **Poppins font** via Google Fonts
- **Material 3** — Colour-scheme seeding, rounded cards, elevated buttons

---

## Tech Stack

| Layer | Library |
|---|---|
| State | `provider ^6.1.1` |
| Storage | `shared_preferences ^2.2.2` |
| Typography | `google_fonts ^6.1.0` |
| Dates | `intl ^0.19.0` |
| Linting | `flutter_lints ^3.0.0` |

---

## Project Structure

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart   # Keys, limits, enums
│   ├── theme/
│   │   └── app_theme.dart       # Light & dark ThemeData
│   └── utils/
│       └── bmi_utils.dart       # Pure calculation & validation helpers
├── models/
│   └── bmi_record.dart          # BmiRecord, BmiCategory
├── providers/
│   ├── bmi_provider.dart        # Calculation + history state
│   └── theme_provider.dart      # Theme mode state
├── screens/
│   ├── home_screen.dart
│   ├── result_screen.dart
│   ├── history_screen.dart
│   └── settings_screen.dart
├── services/
│   └── storage_service.dart     # SharedPreferences abstraction
├── widgets/
│   ├── app_card.dart
│   ├── bmi_gauge.dart           # Custom-painted arc gauge
│   ├── category_badge.dart
│   ├── empty_state.dart
│   └── unit_selector.dart
└── main.dart
```

---

## Getting Started

### Prerequisites

- Flutter SDK ≥ 3.22 (stable channel)
- Dart ≥ 3.0

### Setup

```bash
# 1. Clone / unzip the project
cd bmi_calculator

# 2. Install dependencies
flutter pub get

# 3. Run on a connected device or emulator
flutter run

# 4. Build a release APK
flutter build apk --release

# 5. Build an App Bundle for Play Store
flutter build appbundle --release
```

---

## App Icon

Use the `flutter_launcher_icons` package or Android Studio's **Image Asset Studio**:

```yaml
# Add to pubspec.yaml (dev_dependencies)
flutter_launcher_icons: ^0.13.1

flutter_icons:
  android: true
  ios: false
  image_path: "assets/images/icon.png"   # 1024×1024 px PNG
```

Then run:
```bash
dart run flutter_launcher_icons
```

---

## Splash Screen

Flutter 3 uses the native splash screen via `android/app/src/main/res`. For a Material 3 branded splash:

1. Replace `android/app/src/main/res/drawable/launch_background.xml` with your colour.
2. Or add `flutter_native_splash` to automate it.

---

## Play Store Checklist

- [x] `minSdkVersion 24` (Android 7.0)
- [x] `targetSdkVersion 34`
- [x] No hardcoded API keys
- [x] Null-safe Dart 3
- [x] ProGuard rules configured
- [ ] Sign with a release keystore (`keytool -genkey ...`)
- [ ] Update `applicationId` in `build.gradle`
- [ ] Add app icon (1024×1024 PNG)
- [ ] Add feature graphic (1024×500 PNG) for Play Store listing

---

## BMI Formula

```
BMI = weight (kg) / height (m)²
```

| Category | BMI Range |
|---|---|
| Underweight | < 18.5 |
| Normal Weight | 18.5 – 24.9 |
| Overweight | 25.0 – 29.9 |
| Obese | ≥ 30.0 |

_(Source: World Health Organization)_

---

## License

MIT — free to use and modify for personal or commercial projects.
