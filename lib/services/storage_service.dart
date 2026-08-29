import 'package:shared_preferences/shared_preferences.dart';
import '../models/bmi_record.dart';
import '../core/constants/app_constants.dart';

/// Handles all persistent storage using SharedPreferences.
class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  // ── Factory ────────────────────────────────────────────────────────────────
  static Future<StorageService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  // ── Theme ──────────────────────────────────────────────────────────────────
  AppThemeMode getThemeMode() {
    final raw = _prefs.getString(AppConstants.prefThemeMode);
    return AppThemeMode.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => AppThemeMode.system,
    );
  }

  Future<void> saveThemeMode(AppThemeMode mode) =>
      _prefs.setString(AppConstants.prefThemeMode, mode.name);

  // ── Unit preferences ───────────────────────────────────────────────────────
  HeightUnit getHeightUnit() {
    final raw = _prefs.getString(AppConstants.prefHeightUnit);
    return HeightUnit.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => HeightUnit.cm,
    );
  }

  Future<void> saveHeightUnit(HeightUnit unit) =>
      _prefs.setString(AppConstants.prefHeightUnit, unit.name);

  WeightUnit getWeightUnit() {
    final raw = _prefs.getString(AppConstants.prefWeightUnit);
    return WeightUnit.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => WeightUnit.kg,
    );
  }

  Future<void> saveWeightUnit(WeightUnit unit) =>
      _prefs.setString(AppConstants.prefWeightUnit, unit.name);

  // ── BMI History ────────────────────────────────────────────────────────────
  List<BmiRecord> getHistory() {
    final raw = _prefs.getStringList(AppConstants.prefBmiHistory) ?? [];
    return raw
        .map((s) {
          try {
            return BmiRecord.fromJsonString(s);
          } catch (_) {
            return null;
          }
        })
        .whereType<BmiRecord>()
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  Future<void> saveHistory(List<BmiRecord> records) {
    final raw = records.map((r) => r.toJsonString()).toList();
    return _prefs.setStringList(AppConstants.prefBmiHistory, raw);
  }

  Future<void> addRecord(BmiRecord record) async {
    final history = getHistory();
    history.insert(0, record);
    await saveHistory(history);
  }

  Future<void> deleteRecord(String id) async {
    final history = getHistory()..removeWhere((r) => r.id == id);
    await saveHistory(history);
  }

  Future<void> clearHistory() =>
      _prefs.remove(AppConstants.prefBmiHistory);
}
