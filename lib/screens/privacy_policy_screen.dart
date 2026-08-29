import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

/// Full in-app Privacy Policy screen.
///
/// This policy accurately reflects what the BMI Calculator app does:
/// - All data (BMI records) is stored **only on the user's device** via SharedPreferences.
/// - No personal data is transmitted to any server.
/// - No ads, no analytics SDKs, no authentication.
/// - Uses Google Fonts (fetches fonts from Google's CDN on first run).
/// - Uses Google Play In-App Review API.
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  static final String _lastUpdated =
      DateFormat('MMMM dd, yyyy').format(DateTime(2024, 1, 1));

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header badge ────────────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cs.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: cs.primary.withOpacity( 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.shield_rounded, color: cs.primary, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Your Privacy Matters',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: cs.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'BMI Calculator does not collect, store, or transmit '
                      'any personal data to external servers. Everything stays on your device.',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: cs.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Last updated: $_lastUpdated',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              _Section(
                number: '1',
                title: 'Introduction',
                body: 'This Privacy Policy describes how BMI Calculator '
                    '("the App", "we", "us", or "our") handles information '
                    'when you use our mobile application on Android.\n\n'
                    'By using the App you acknowledge that you have read and '
                    'understood this policy. If you disagree with any part of '
                    'it, please uninstall the App.',
              ),

              _Section(
                number: '2',
                title: 'Information We Collect',
                body: 'The App does not collect any personally identifiable '
                    'information (PII).\n\n'
                    'The only data the App stores is the information you '
                    'voluntarily enter:\n\n'
                    '• Height values (in centimetres or feet/inches)\n'
                    '• Weight values (in kilograms or pounds)\n'
                    '• Calculated BMI results and their timestamps\n\n'
                    'This data is stored exclusively on your device using '
                    'Android\'s SharedPreferences mechanism. It never leaves '
                    'your device and is never transmitted to us or any third party.',
              ),

              _Section(
                number: '3',
                title: 'How Information Is Used',
                body: 'The data you enter is used solely to:\n\n'
                    '• Calculate your Body Mass Index (BMI)\n'
                    '• Display your BMI category and health recommendation\n'
                    '• Show your calculation history within the App\n\n'
                    'We do not use your data for advertising, profiling, '
                    'analytics, or any purpose beyond the core functionality '
                    'of the App.',
              ),

              _Section(
                number: '4',
                title: 'Data Storage and Security',
                body: 'All data is stored locally on your device using the '
                    'Android SharedPreferences API. This storage is:\n\n'
                    '• Private to the App — other apps cannot read it\n'
                    '• Removed automatically if you uninstall the App\n'
                    '• Subject to Android\'s built-in file-system security\n\n'
                    'Because no data is transmitted, there is no risk of '
                    'server-side data breach for your BMI records.\n\n'
                    'You can delete all stored records at any time from the '
                    'History screen using the "Clear All" option.',
              ),

              _Section(
                number: '5',
                title: 'Third-Party Services',
                body: 'The App integrates the following third-party services:\n\n'
                    '• Google Fonts — Used to download the Poppins typeface on '
                    'first launch. Font files are requested from Google\'s CDN '
                    '(fonts.googleapis.com). After the initial download, fonts '
                    'may be cached on your device. Google\'s Privacy Policy '
                    'applies to this request: https://policies.google.com/privacy\n\n'
                    '• Google Play In-App Review API — When you choose to rate '
                    'the App, the App calls Google Play\'s In-App Review API to '
                    'display Google\'s native review dialog. Any rating or review '
                    'you submit is handled entirely by Google Play and is governed '
                    'by Google\'s Privacy Policy. We do not receive or store your '
                    'rating.\n\n'
                    'No advertising SDKs, analytics SDKs, crash-reporting tools, '
                    'or social-login SDKs are included in the App.',
              ),

              _Section(
                number: '6',
                title: 'Permissions',
                body: 'The App requests no Android runtime permissions '
                    '(such as camera, contacts, location, or microphone).\n\n'
                    'The only implicit capabilities used are:\n\n'
                    '• Internet access — required solely for the initial Google '
                    'Fonts download. Declared via the android.permission.INTERNET '
                    'manifest permission. The App does not use the internet for '
                    'any other purpose.\n\n'
                    '• QUERY_ALL_PACKAGES / share intent — when you use the '
                    '"Share App" feature, Android\'s standard share sheet is '
                    'invoked. The App does not enumerate or store the list of '
                    'apps present on your device.',
              ),

              _Section(
                number: '7',
                title: 'Data Sharing',
                body: 'We do not sell, rent, trade, or share your data with '
                    'any third parties.\n\n'
                    'The only scenario in which data leaves your device is:\n\n'
                    '• When you explicitly use the "Share App" feature — this '
                    'triggers Android\'s native share sheet and shares only a '
                    'static text message containing the App\'s name and its '
                    'Google Play Store link. No BMI data is shared.',
              ),

              _Section(
                number: '8',
                title: 'Children\'s Privacy',
                body: 'The App is designed to be suitable for general audiences '
                    'and does not knowingly collect any data from children under '
                    'the age of 13 (or the applicable age of digital consent in '
                    'your country).\n\n'
                    'Since no personal data is collected or transmitted, the App '
                    'presents minimal privacy risk for users of any age. Parents '
                    'or guardians who have questions are welcome to contact us '
                    'using the information in Section 11.',
              ),

              _Section(
                number: '9',
                title: 'User Rights',
                body: 'Because all your data is stored locally on your device, '
                    'you have full control over it at all times:\n\n'
                    '• View your data — open the History screen\n'
                    '• Delete individual records — swipe left on a record or '
                    'tap the delete icon\n'
                    '• Delete all records — tap "Clear All" in the History screen\n'
                    '• Delete all data — uninstall the App\n\n'
                    'No account, email address, or request to us is required '
                    'to exercise any of these rights.',
              ),

              _Section(
                number: '10',
                title: 'Changes to This Privacy Policy',
                body: 'We may update this Privacy Policy from time to time. '
                    'When we do, we will update the "Last updated" date at the '
                    'top of this page and publish the new version with the next '
                    'App update on Google Play.\n\n'
                    'We encourage you to review this policy periodically. '
                    'Continued use of the App after a policy update constitutes '
                    'your acceptance of the revised terms.',
              ),

              _Section(
                number: '11',
                title: 'Contact Information',
                body: 'If you have questions, concerns, or requests regarding '
                    'this Privacy Policy or the App\'s data practices, please '
                    'contact us at:\n\n'
                    'Email: privacy@example.com\n\n'
                    'Replace the email above with your actual contact address '
                    'before publishing to the Play Store.',
                isLast: true,
              ),

              const SizedBox(height: 16),

              // ── Footer ───────────────────────────────────────────────────────
              Center(
                child: Text(
                  '© 2024 BMI Calculator. All rights reserved.',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Private sub-widget ───────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  final String number;
  final String title;
  final String body;
  final bool isLast;

  const _Section({
    required this.number,
    required this.title,
    required this.body,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: cs.primary.withOpacity( 0.12),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                number,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: cs.primary,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 38),
          child: Text(
            body,
            style: GoogleFonts.poppins(
              fontSize: 13.5,
              color: cs.onSurfaceVariant,
              height: 1.65,
            ),
          ),
        ),
        if (!isLast) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Divider(color: cs.outlineVariant),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}
