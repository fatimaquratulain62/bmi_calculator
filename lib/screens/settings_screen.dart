// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../core/constants/app_constants.dart';
// import '../providers/theme_provider.dart';
// import '../widgets/app_card.dart';

// /// App settings: theme, about, links.
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = context.watch<ThemeProvider>();
//     final cs = Theme.of(context).colorScheme;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Settings',
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
//         children: [
//           // ── Theme section ────────────────────────────────────────────────
//           _SectionHeader(label: 'Appearance'),
//           const SizedBox(height: 8),
//           AppCard(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Theme',
//                   style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 ...AppThemeMode.values.map((mode) {
//                   final selected = themeProvider.mode == mode;
//                   return RadioListTile<AppThemeMode>(
//                     dense: true,
//                     contentPadding: EdgeInsets.zero,
//                     visualDensity: VisualDensity.compact,
//                     title: Text(
//                       mode.label,
//                       style: GoogleFonts.poppins(fontSize: 14),
//                     ),
//                     value: mode,
//                     groupValue: themeProvider.mode,
//                     onChanged: (v) {
//                       if (v != null) themeProvider.setMode(v);
//                     },
//                     secondary: Icon(
//                       _themeIcon(mode),
//                       color: selected ? cs.primary : cs.onSurfaceVariant,
//                     ),
//                   );
//                 }),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),

//           // ── About section ─────────────────────────────────────────────────
//           _SectionHeader(label: 'About'),
//           const SizedBox(height: 8),
//           AppCard(
//             child: Column(
//               children: [
//                 _SettingsTile(
//                   icon: Icons.share_rounded,
//                   label: 'Share App',
//                   onTap: () => _showSnackBar(context, 'Share feature coming soon!'),
//                 ),
//                 const Divider(height: 1),
//                 _SettingsTile(
//                   icon: Icons.star_rounded,
//                   label: 'Rate App',
//                   onTap: () => _showSnackBar(context, 'Rate us on the Play Store!'),
//                 ),
//                 const Divider(height: 1),
//                 _SettingsTile(
//                   icon: Icons.privacy_tip_rounded,
//                   label: 'Privacy Policy',
//                   onTap: () => _showSnackBar(
//                       context, 'Opening: ${AppConstants.privacyPolicyUrl}'),
//                 ),
//                 const Divider(height: 1),
//                 _SettingsTile(
//                   icon: Icons.info_rounded,
//                   label: 'App Version',
//                   trailing: Text(
//                     AppConstants.appVersion,
//                     style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       color: cs.onSurfaceVariant,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 24),

//           // ── BMI scale reference ───────────────────────────────────────────
//           _SectionHeader(label: 'BMI Reference'),
//           const SizedBox(height: 8),
//           AppCard(
//             child: Column(
//               children: [
//                 _BmiScaleRow(label: 'Underweight', range: '< 18.5',
//                     color: const Color(0xFF3B82F6)),
//                 const Divider(height: 16),
//                 _BmiScaleRow(label: 'Normal Weight', range: '18.5 – 24.9',
//                     color: const Color(0xFF22C55E)),
//                 const Divider(height: 16),
//                 _BmiScaleRow(label: 'Overweight', range: '25.0 – 29.9',
//                     color: const Color(0xFFF59E0B)),
//                 const Divider(height: 16),
//                 _BmiScaleRow(label: 'Obese', range: '≥ 30.0',
//                     color: const Color(0xFFEF4444)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   IconData _themeIcon(AppThemeMode mode) {
//     switch (mode) {
//       case AppThemeMode.light:
//         return Icons.light_mode_rounded;
//       case AppThemeMode.dark:
//         return Icons.dark_mode_rounded;
//       case AppThemeMode.system:
//         return Icons.brightness_auto_rounded;
//     }
//   }

//   void _showSnackBar(BuildContext context, String msg) {
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text(msg)));
//   }
// }

// class _SectionHeader extends StatelessWidget {
//   final String label;
//   const _SectionHeader({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       label.toUpperCase(),
//       style: GoogleFonts.poppins(
//         fontSize: 11,
//         fontWeight: FontWeight.w700,
//         letterSpacing: 1.2,
//         color: Theme.of(context).colorScheme.primary,
//       ),
//     );
//   }
// }

// class _SettingsTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback? onTap;
//   final Widget? trailing;

//   const _SettingsTile({
//     required this.icon,
//     required this.label,
//     this.onTap,
//     this.trailing,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return ListTile(
//       dense: true,
//       contentPadding: EdgeInsets.zero,
//       leading: Icon(icon, color: cs.primary, size: 22),
//       title: Text(label, style: GoogleFonts.poppins(fontSize: 14)),
//       trailing: trailing ?? (onTap != null
//           ? Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant)
//           : null),
//       onTap: onTap,
//     );
//   }
// }

// class _BmiScaleRow extends StatelessWidget {
//   final String label;
//   final String range;
//   final Color color;

//   const _BmiScaleRow({
//     required this.label,
//     required this.range,
//     required this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Container(
//           width: 14,
//           height: 14,
//           decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Text(label, style: GoogleFonts.poppins(fontSize: 14)),
//         ),
//         Text(
//           range,
//           style: GoogleFonts.poppins(
//             fontSize: 13,
//             color: color,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_constants.dart';
import '../providers/theme_provider.dart';
import '../services/review_service.dart';
import '../services/share_service.dart';
import '../widgets/app_card.dart';
import 'privacy_policy_screen.dart';

/// App settings: theme, about, links.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _sharingInProgress = false;
  bool _reviewInProgress = false;

  // ── Share App ──────────────────────────────────────────────────────────────
  Future<void> _shareApp() async {
    if (_sharingInProgress) return;
    setState(() => _sharingInProgress = true);
    try {
      await ShareService.shareApp();
    } finally {
      if (mounted) setState(() => _sharingInProgress = false);
    }
  }

  // ── Rate App ───────────────────────────────────────────────────────────────
  Future<void> _rateApp() async {
    if (_reviewInProgress) return;
    setState(() => _reviewInProgress = true);
    try {
      await InAppReviewService.requestReview(context);
    } finally {
      if (mounted) setState(() => _reviewInProgress = false);
    }
  }

  // ── Privacy Policy ─────────────────────────────────────────────────────────
  void _openPrivacyPolicy() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen()),
    );
  }

  // ── Theme icon helper ──────────────────────────────────────────────────────
  IconData _themeIcon(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return Icons.light_mode_rounded;
      case AppThemeMode.dark:
        return Icons.dark_mode_rounded;
      case AppThemeMode.system:
        return Icons.brightness_auto_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          // ── Appearance ────────────────────────────────────────────────────
          _SectionHeader(label: 'Appearance'),
          const SizedBox(height: 8),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Theme',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...AppThemeMode.values.map((mode) {
                  final selected = themeProvider.mode == mode;
                  return RadioListTile<AppThemeMode>(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                    title: Text(
                      mode.label,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    value: mode,
                    groupValue: themeProvider.mode,
                    onChanged: (v) {
                      if (v != null) themeProvider.setMode(v);
                    },
                    secondary: Icon(
                      _themeIcon(mode),
                      color: selected ? cs.primary : cs.onSurfaceVariant,
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── About ─────────────────────────────────────────────────────────
          _SectionHeader(label: 'About'),
          const SizedBox(height: 8),
          AppCard(
            child: Column(
              children: [
                // Share App — opens native Android/iOS share sheet
                _SettingsTile(
                  icon: Icons.share_rounded,
                  label: 'Share App',
                  loading: _sharingInProgress,
                  onTap: _shareApp,
                ),
                const Divider(height: 1),

                // Rate App — Google Play In-App Review (falls back to Play Store)
                _SettingsTile(
                  icon: Icons.star_rounded,
                  label: 'Rate App',
                  loading: _reviewInProgress,
                  onTap: _rateApp,
                ),
                const Divider(height: 1),

                // Privacy Policy — opens in-app screen
                _SettingsTile(
                  icon: Icons.privacy_tip_rounded,
                  label: 'Privacy Policy',
                  onTap: _openPrivacyPolicy,
                ),
                const Divider(height: 1),

                // App Version — no action
                _SettingsTile(
                  icon: Icons.info_rounded,
                  label: 'App Version',
                  trailing: Text(
                    AppConstants.appVersion,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── BMI Reference ─────────────────────────────────────────────────
          _SectionHeader(label: 'BMI Reference'),
          const SizedBox(height: 8),
          AppCard(
            child: Column(
              children: [
                _BmiScaleRow(
                    label: 'Underweight',
                    range: '< 18.5',
                    color: const Color(0xFF3B82F6)),
                const Divider(height: 16),
                _BmiScaleRow(
                    label: 'Normal Weight',
                    range: '18.5 – 24.9',
                    color: const Color(0xFF22C55E)),
                const Divider(height: 16),
                _BmiScaleRow(
                    label: 'Overweight',
                    range: '25.0 – 29.9',
                    color: const Color(0xFFF59E0B)),
                const Divider(height: 16),
                _BmiScaleRow(
                    label: 'Obese',
                    range: '≥ 30.0',
                    color: const Color(0xFFEF4444)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ──────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool loading;

  const _SettingsTile({
    required this.icon,
    required this.label,
    this.onTap,
    this.trailing,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    Widget? trailingWidget;
    if (loading) {
      trailingWidget = SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: cs.primary,
        ),
      );
    } else if (trailing != null) {
      trailingWidget = trailing;
    } else if (onTap != null) {
      trailingWidget =
          Icon(Icons.chevron_right_rounded, color: cs.onSurfaceVariant);
    }

    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: cs.primary, size: 22),
      title: Text(label, style: GoogleFonts.poppins(fontSize: 14)),
      trailing: trailingWidget,
      onTap: loading ? null : onTap,
    );
  }
}

class _BmiScaleRow extends StatelessWidget {
  final String label;
  final String range;
  final Color color;

  const _BmiScaleRow({
    required this.label,
    required this.range,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: GoogleFonts.poppins(fontSize: 14)),
        ),
        Text(
          range,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
