import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/bmi_record.dart';
import '../core/utils/bmi_utils.dart';

/// Semi-circular arc gauge visualising BMI on a colour scale.
class BmiGauge extends StatefulWidget {
  final double bmi;
  final BmiCategory category;
  final double size;

  const BmiGauge({
    super.key,
    required this.bmi,
    required this.category,
    this.size = 220,
  });

  @override
  State<BmiGauge> createState() => _BmiGaugeState();
}

class _BmiGaugeState extends State<BmiGauge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// Maps BMI to a 0–1 position on the gauge arc (clamped 10–45).
  double _bmiToProgress(double bmi) => ((bmi - 10) / 35).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final color = BmiUtils.categoryColor(widget.category);
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        return CustomPaint(
          size: Size(widget.size, widget.size * 0.6),
          painter: _GaugePainter(
            progress: _bmiToProgress(widget.bmi) * _anim.value,
            accentColor: color,
            backgroundColor:
                Theme.of(context).colorScheme.surfaceContainerHighest,
          ),
        );
      },
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double progress;
  final Color accentColor;
  final Color backgroundColor;

  _GaugePainter({
    required this.progress,
    required this.accentColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height * 0.95;
    final radius = size.width * 0.44;
    const startAngle = math.pi;
    const sweepAngle = math.pi;

    // Background arc
    final bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(cx, cy), radius: radius),
      startAngle,
      sweepAngle,
      false,
      bgPaint,
    );

    // Gradient segments (underweight→normal→overweight→obese)
    final segmentColors = [
      AppTheme.underweightColor,
      AppTheme.normalColor,
      AppTheme.overweightColor,
      AppTheme.obeseColor,
    ];
    final segmentEnds = [0.243, 0.571, 0.743, 1.0];
    double segStart = 0;
    for (var i = 0; i < segmentColors.length; i++) {
      final segEnd = segmentEnds[i];
      final clampedEnd = math.min(progress, segEnd);
      if (clampedEnd > segStart) {
        final paint = Paint()
          ..color = segmentColors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = 18
          ..strokeCap = StrokeCap.butt;
        canvas.drawArc(
          Rect.fromCircle(center: Offset(cx, cy), radius: radius),
          startAngle + segStart * sweepAngle,
          (clampedEnd - segStart) * sweepAngle,
          false,
          paint,
        );
      }
      segStart = segEnd;
      if (progress <= segEnd) break;
    }

    // Needle
    final angle = math.pi + progress * math.pi;
    final needleLength = radius - 10;
    final needlePaint = Paint()
      ..color = accentColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + needleLength * math.cos(angle),
          cy + needleLength * math.sin(angle)),
      needlePaint,
    );

    // Centre dot
    canvas.drawCircle(
      Offset(cx, cy),
      8,
      Paint()..color = accentColor,
    );
    canvas.drawCircle(
      Offset(cx, cy),
      5,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      old.progress != progress || old.accentColor != accentColor;
}
