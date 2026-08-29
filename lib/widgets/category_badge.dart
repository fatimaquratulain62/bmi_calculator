import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/bmi_record.dart';
import '../core/utils/bmi_utils.dart';

/// Pill-shaped badge showing BMI category with matching colour.
class CategoryBadge extends StatelessWidget {
  final BmiCategory category;
  final double fontSize;

  const CategoryBadge({
    super.key,
    required this.category,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final color = BmiUtils.categoryColor(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity( 0.15),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(BmiUtils.categoryIcon(category), color: color, size: fontSize + 2),
          const SizedBox(width: 6),
          Text(
            category.label,
            style: GoogleFonts.poppins(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
