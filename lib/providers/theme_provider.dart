import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../core/constants/app_constants.dart';

/// Manages app-wide theme mode with persistence.
class ThemeProvider extends ChangeNotifier {
  final StorageService _storage;
  AppThemeMode _mode;

  ThemeProvider(this._storage) : _mode = _storage.getThemeMode();

  AppThemeMode get mode => _mode;

  ThemeMode get themeMode {
    switch (_mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  Future<void> setMode(AppThemeMode mode) async {
    _mode = mode;
    await _storage.saveThemeMode(mode);
    notifyListeners();
  }
}
