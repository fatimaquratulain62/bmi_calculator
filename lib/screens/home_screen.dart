import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_constants.dart';
import '../core/utils/bmi_utils.dart';
import '../providers/bmi_provider.dart';
import '../widgets/app_card.dart';
import '../widgets/unit_selector.dart';
import 'result_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _heightCmCtrl = TextEditingController();
  final _heightFtCtrl = TextEditingController();
  final _heightInCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();

  bool _isCalculating = false;

  @override
  void dispose() {
    _heightCmCtrl.dispose();
    _heightFtCtrl.dispose();
    _heightInCtrl.dispose();
    _weightCtrl.dispose();
    super.dispose();
  }

  Future<void> _calculate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isCalculating = true);

    final provider = context.read<BmiProvider>();

    double heightCm;
    if (provider.heightUnit == HeightUnit.cm) {
      heightCm = double.parse(_heightCmCtrl.text.trim());
    } else {
      final feet = double.tryParse(_heightFtCtrl.text.trim()) ?? 0;
      final inches = double.tryParse(_heightInCtrl.text.trim()) ?? 0;
      heightCm = BmiUtils.feetInchesToCm(feet, inches);
    }

    double weightKg;
    if (provider.weightUnit == WeightUnit.kg) {
      weightKg = double.parse(_weightCtrl.text.trim());
    } else {
      weightKg = BmiUtils.lbsToKg(double.parse(_weightCtrl.text.trim()));
    }

    final record = await provider.calculate(
      heightCm: heightCm,
      weightKg: weightKg,
    );

    if (!mounted) return;
    setState(() => _isCalculating = false);

    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, animation, __) => ResultScreen(record: record),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final provider = context.watch<BmiProvider>();

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'History',
            icon: const Icon(Icons.history_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const HistoryScreen()),
            ),
          ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_rounded),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _HeroIllustration(cs: cs),
                const SizedBox(height: 28),

                // ── Height card ──────────────────────────────────────────────
                _SectionLabel(label: 'Height'),
                const SizedBox(height: 8),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter your height',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          UnitSelector<HeightUnit>(
                            options: HeightUnit.values,
                            selected: provider.heightUnit,
                            labelOf: (u) => u.label,
                            onChanged: (u) {
                              provider.setHeightUnit(u);
                              _heightCmCtrl.clear();
                              _heightFtCtrl.clear();
                              _heightInCtrl.clear();
                              _formKey.currentState?.reset();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      if (provider.heightUnit == HeightUnit.cm)
                        TextFormField(
                          controller: _heightCmCtrl,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*'))
                          ],
                          decoration: const InputDecoration(
                            hintText: 'e.g. 175',
                            suffixText: 'cm',
                          ),
                          validator: BmiUtils.validateHeightCm,
                        )
                      else
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _heightFtCtrl,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  hintText: 'e.g. 5',
                                  suffixText: 'ft',
                                ),
                                validator: BmiUtils.validateFeet,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _heightInCtrl,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: const InputDecoration(
                                  hintText: 'e.g. 9',
                                  suffixText: 'in',
                                ),
                                validator: BmiUtils.validateInches,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ── Weight card ──────────────────────────────────────────────
                _SectionLabel(label: 'Weight'),
                const SizedBox(height: 8),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Enter your weight',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          UnitSelector<WeightUnit>(
                            options: WeightUnit.values,
                            selected: provider.weightUnit,
                            labelOf: (u) => u.label,
                            onChanged: (u) {
                              provider.setWeightUnit(u);
                              _weightCtrl.clear();
                              _formKey.currentState?.reset();
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _weightCtrl,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d*'))
                        ],
                        decoration: InputDecoration(
                          hintText: provider.weightUnit == WeightUnit.kg
                              ? 'e.g. 70'
                              : 'e.g. 154',
                          suffixText: provider.weightUnit.label,
                        ),
                        validator: provider.weightUnit == WeightUnit.kg
                            ? BmiUtils.validateWeightKg
                            : BmiUtils.validateWeightLbs,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // ── Calculate button ─────────────────────────────────────────
                SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _isCalculating ? null : _calculate,
                    child: _isCalculating
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text('Calculate BMI'),
                  ),
                ),

                const SizedBox(height: 12),

                // ── View History button ──────────────────────────────────────
                SizedBox(
                  height: 54,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HistoryScreen()),
                    ),
                    icon: const Icon(Icons.history_rounded),
                    label: Text(
                      'View History (${provider.history.length})',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Private sub-widgets ──────────────────────────────────────────────────────

class _HeroIllustration extends StatelessWidget {
  final ColorScheme cs;
  const _HeroIllustration({required this.cs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cs.primary.withOpacity(0.15),
            cs.secondary.withOpacity(0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -1,
            top: 0,
            bottom: 0,
            child: Icon(
              Icons.monitor_weight_outlined,
              size: 110,
              color: cs.primary.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Know Your BMI',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: cs.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Body Mass Index helps assess\nyour healthy weight range.',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: cs.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
