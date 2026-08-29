import 'dart:convert';

/// Represents a single BMI calculation record stored in history.
class BmiRecord {
  final String id;
  final DateTime date;
  final double heightCm;
  final double weightKg;
  final double bmi;
  final BmiCategory category;

  const BmiRecord({
    required this.id,
    required this.date,
    required this.heightCm,
    required this.weightKg,
    required this.bmi,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'heightCm': heightCm,
        'weightKg': weightKg,
        'bmi': bmi,
        'category': category.name,
      };

  factory BmiRecord.fromJson(Map<String, dynamic> json) => BmiRecord(
        id: json['id'] as String,
        date: DateTime.parse(json['date'] as String),
        heightCm: (json['heightCm'] as num).toDouble(),
        weightKg: (json['weightKg'] as num).toDouble(),
        bmi: (json['bmi'] as num).toDouble(),
        category: BmiCategory.values.firstWhere(
          (e) => e.name == json['category'],
          orElse: () => BmiCategory.normal,
        ),
      );

  String toJsonString() => jsonEncode(toJson());

  factory BmiRecord.fromJsonString(String jsonString) =>
      BmiRecord.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
}

/// BMI categories as per WHO classification.
enum BmiCategory {
  underweight,
  normal,
  overweight,
  obese;

  String get label {
    switch (this) {
      case BmiCategory.underweight:
        return 'Underweight';
      case BmiCategory.normal:
        return 'Normal Weight';
      case BmiCategory.overweight:
        return 'Overweight';
      case BmiCategory.obese:
        return 'Obese';
    }
  }

  String get recommendation {
    switch (this) {
      case BmiCategory.underweight:
        return 'Consider increasing calorie intake with nutrient-dense foods. Consult a healthcare provider for a personalized plan.';
      case BmiCategory.normal:
        return 'Keep maintaining a balanced diet and regular exercise. You\'re doing great!';
      case BmiCategory.overweight:
        return 'Consider adopting a balanced diet and increasing physical activity. Small changes lead to big results.';
      case BmiCategory.obese:
        return 'It\'s recommended to consult a healthcare provider for a structured weight management plan.';
    }
  }
}
