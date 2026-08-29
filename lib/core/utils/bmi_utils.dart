import 'package:flutter/material.dart';
import '../../models/bmi_record.dart';
import '../../core/theme/app_theme.dart';
import '../constants/app_constants.dart';

/// Pure functions for BMI calculation and classification.
class BmiUtils {
  BmiUtils._();

  /// Calculates BMI from weight in kg and height in cm.
  static double calculate({
    required double weightKg,
    required double heightCm,
  }) {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// Returns the [BmiCategory] for a given BMI value.
  static BmiCategory classify(double bmi) {
    if (bmi < AppConstants.bmiUnderweightMax) return BmiCategory.underweight;
    if (bmi <= AppConstants.bmiNormalMax) return BmiCategory.normal;
    if (bmi <= AppConstants.bmiOverweightMax) return BmiCategory.overweight;
    return BmiCategory.obese;
  }

  /// Returns the healthy weight range (kg) for a given height in cm.
  static (double min, double max) healthyWeightRange(double heightCm) {
    final hM = heightCm / 100;
    return (
      AppConstants.bmiUnderweightMax * hM * hM,
      AppConstants.bmiNormalMax * hM * hM
    );
  }

  /// Converts cm to feet and inches as a formatted string.
  static String cmToFeetInches(double cm) {
    final totalInches = cm / AppConstants.cmPerInch;
    final feet = totalInches ~/ AppConstants.inchesPerFoot;
    final inches = (totalInches % AppConstants.inchesPerFoot).round();
    return "$feet′ $inches″";
  }

  /// Converts feet + inches to cm.
  static double feetInchesToCm(double feet, double inches) {
    final totalInches = feet * AppConstants.inchesPerFoot + inches;
    return totalInches * AppConstants.cmPerInch;
  }

  /// Converts lbs to kg.
  static double lbsToKg(double lbs) => lbs * AppConstants.kgPerLb;

  /// Converts kg to lbs.
  static double kgToLbs(double kg) => kg / AppConstants.kgPerLb;

  /// Returns the accent colour for a BMI category.
  static Color categoryColor(BmiCategory cat) {
    switch (cat) {
      case BmiCategory.underweight:
        return AppTheme.underweightColor;
      case BmiCategory.normal:
        return AppTheme.normalColor;
      case BmiCategory.overweight:
        return AppTheme.overweightColor;
      case BmiCategory.obese:
        return AppTheme.obeseColor;
    }
  }

  /// Returns an icon suited to the category.
  static IconData categoryIcon(BmiCategory cat) {
    switch (cat) {
      case BmiCategory.underweight:
        return Icons.trending_down_rounded;
      case BmiCategory.normal:
        return Icons.check_circle_rounded;
      case BmiCategory.overweight:
        return Icons.trending_up_rounded;
      case BmiCategory.obese:
        return Icons.warning_rounded;
    }
  }

  /// Validates height in cm; returns error string or null.
  static String? validateHeightCm(String? value) {
    if (value == null || value.trim().isEmpty) return 'Height is required';
    final parsed = double.tryParse(value.trim());
    if (parsed == null) return 'Enter a valid number';
    if (parsed <= 0) return 'Height must be greater than zero';
    if (parsed < AppConstants.minHeightCm) {
      return 'Height must be at least ${AppConstants.minHeightCm.toInt()} cm';
    }
    if (parsed > AppConstants.maxHeightCm) {
      return 'Height must be less than ${AppConstants.maxHeightCm.toInt()} cm';
    }
    return null;
  }

  /// Validates weight in kg; returns error string or null.
  static String? validateWeightKg(String? value) {
    if (value == null || value.trim().isEmpty) return 'Weight is required';
    final parsed = double.tryParse(value.trim());
    if (parsed == null) return 'Enter a valid number';
    if (parsed <= 0) return 'Weight must be greater than zero';
    if (parsed < AppConstants.minWeightKg) {
      return 'Weight must be at least ${AppConstants.minWeightKg.toInt()} kg';
    }
    if (parsed > AppConstants.maxWeightKg) {
      return 'Weight must be less than ${AppConstants.maxWeightKg.toInt()} kg';
    }
    return null;
  }

  /// Validates feet input; returns error or null.
  static String? validateFeet(String? value) {
    if (value == null || value.trim().isEmpty) return 'Feet is required';
    final parsed = double.tryParse(value.trim());
    if (parsed == null) return 'Enter a valid number';
    if (parsed < 1 || parsed > 9) return 'Feet must be between 1 and 9';
    return null;
  }

  /// Validates inches input; returns error or null.
  static String? validateInches(String? value) {
    if (value == null || value.trim().isEmpty) return null; // inches optional
    final parsed = double.tryParse(value.trim());
    if (parsed == null) return 'Enter a valid number';
    if (parsed < 0 || parsed >= 12) return 'Inches must be 0–11';
    return null;
  }

  /// Validates weight in lbs; returns error string or null.
  static String? validateWeightLbs(String? value) {
    if (value == null || value.trim().isEmpty) return 'Weight is required';
    final parsed = double.tryParse(value.trim());
    if (parsed == null) return 'Enter a valid number';
    if (parsed <= 0) return 'Weight must be greater than zero';
    final kg = lbsToKg(parsed);
    if (kg < AppConstants.minWeightKg) return 'Weight is too low';
    if (kg > AppConstants.maxWeightKg) return 'Weight is too high';
    return null;
  }
}
