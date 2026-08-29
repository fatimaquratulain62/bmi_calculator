import 'package:flutter/material.dart';
import '../models/bmi_record.dart';
import '../services/storage_service.dart';
import '../core/constants/app_constants.dart';
import '../core/utils/bmi_utils.dart';

/// Manages BMI calculation state and history.
class BmiProvider extends ChangeNotifier {
  final StorageService _storage;

  BmiProvider(this._storage) {
    _loadHistory();
    _heightUnit = _storage.getHeightUnit();
    _weightUnit = _storage.getWeightUnit();
  }

  // ── Unit state ─────────────────────────────────────────────────────────────
  HeightUnit _heightUnit = HeightUnit.cm;
  WeightUnit _weightUnit = WeightUnit.kg;

  HeightUnit get heightUnit => _heightUnit;
  WeightUnit get weightUnit => _weightUnit;

  void setHeightUnit(HeightUnit unit) {
    _heightUnit = unit;
    _storage.saveHeightUnit(unit);
    notifyListeners();
  }

  void setWeightUnit(WeightUnit unit) {
    _weightUnit = unit;
    _storage.saveWeightUnit(unit);
    notifyListeners();
  }

  // ── History state ──────────────────────────────────────────────────────────
  List<BmiRecord> _history = [];
  List<BmiRecord> get history => List.unmodifiable(_history);

  void _loadHistory() {
    _history = _storage.getHistory();
  }

  // ── Calculation ────────────────────────────────────────────────────────────

  /// Computes BMI and saves a record. Returns the new [BmiRecord].
  Future<BmiRecord> calculate({
    required double heightCm,
    required double weightKg,
  }) async {
    final bmi = BmiUtils.calculate(heightCm: heightCm, weightKg: weightKg);
    final category = BmiUtils.classify(bmi);

    final record = BmiRecord(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      heightCm: heightCm,
      weightKg: weightKg,
      bmi: double.parse(bmi.toStringAsFixed(1)),
      category: category,
    );

    await _storage.addRecord(record);
    _history = _storage.getHistory();
    notifyListeners();
    return record;
  }

  // ── History management ─────────────────────────────────────────────────────
  Future<void> deleteRecord(String id) async {
    await _storage.deleteRecord(id);
    _history = _storage.getHistory();
    notifyListeners();
  }

  Future<void> clearHistory() async {
    await _storage.clearHistory();
    _history = [];
    notifyListeners();
  }
}
