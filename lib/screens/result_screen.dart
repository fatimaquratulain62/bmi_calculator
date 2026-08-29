import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/utils/bmi_utils.dart';
import '../models/bmi_record.dart';
import '../widgets/bmi_gauge.dart';
import '../widgets/category_badge.dart';
import '../widgets/app_card.dart';

/// Displays the BMI result with gauge, category, and health advice.
class ResultScreen extends StatelessWidget {
  final BmiRecord record;

  const ResultScreen({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = BmiUtils.categoryColor(record.category);
    final (minW, maxW) = BmiUtils.healthyWeightRange(record.heightCm);

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(
          'Your Result',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Gauge card ─────────────────────────────────────────────────
              AppCard(
                color: color.withOpacity(0.06),
                child: Column(
                  children: [
                    BmiGauge(bmi: record.bmi, category: record.category),
                    const SizedBox(height: 8),

                    // Large BMI number
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: record.bmi),
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.easeOutCubic,
                      builder: (_, val, __) => Text(
                        val.toStringAsFixed(1),
                        style: GoogleFonts.poppins(
                          fontSize: 72,
                          fontWeight: FontWeight.w800,
                          color: color,
                          height: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'BMI',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CategoryBadge(category: record.category, fontSize: 15),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Recommendation card ────────────────────────────────────────
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.favorite_rounded,
                            color: color, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Health Advice',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      record.category.recommendation,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: cs.onSurfaceVariant,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ── Stats row ──────────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      icon: Icons.straighten_rounded,
                      label: 'Height',
                      value: '${record.heightCm.toStringAsFixed(1)} cm',
                      sub: BmiUtils.cmToFeetInches(record.heightCm),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      icon: Icons.monitor_weight_rounded,
                      label: 'Weight',
                      value: '${record.weightKg.toStringAsFixed(1)} kg',
                      sub:
                          '${BmiUtils.kgToLbs(record.weightKg).toStringAsFixed(1)} lbs',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ── Healthy range card ─────────────────────────────────────────
              AppCard(
                child: Row(
                  children: [
                    Icon(Icons.balance_rounded, color: cs.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Healthy Weight Range',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            '${minW.toStringAsFixed(1)} – ${maxW.toStringAsFixed(1)} kg',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'for your height of ${record.heightCm.toStringAsFixed(1)} cm',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ── CTA ────────────────────────────────────────────────────────
              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.calculate_rounded),
                  label: const Text('Calculate Again'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String sub;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: cs.primary, size: 22),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: cs.onSurfaceVariant,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            sub,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
