import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

/// Handles the Google Play In-App Review flow with a graceful Play Store fallback.
///
/// Flow:
///   1. Check if the In-App Review API is available on this device.
///   2. Request a [ReviewInfo] object from Google Play.
///   3. Launch the native Google review dialog via [launchReviewFlow].
///   4. If any step fails, fall back to opening the Play Store listing.
///
/// Important: Google Play rate-limits how often the native dialog is shown
/// to users — this is intentional and cannot be overridden.
class InAppReviewService {
  InAppReviewService._();

  static final InAppReview _inAppReview = InAppReview.instance;

  /// The real Play Store URL built from the app's application ID.
  static const String _playStoreUrl =
      'https://play.google.com/store/apps/details?id=com.example.bmi_calculator';

  /// Requests the native Google Play review dialog.
  ///
  /// Call this when the user taps "Rate App". Pass [context] so that a
  /// SnackBar can be shown on failure if the Play Store is also unavailable.
  static Future<void> requestReview(BuildContext context) async {
    try {
      final isAvailable = await _inAppReview.isAvailable();

      if (isAvailable) {
        // Ask Google Play for a ReviewInfo token, then launch the native UI.
        // Google decides whether and when to show the dialog — do not attempt
        // to detect whether the dialog was actually displayed.
        await _inAppReview.requestReview();
      } else {
        // In-App Review not available (e.g. emulator, side-loaded APK, or
        // the API is rate-limited). Open the Play Store as a fallback.
        await _openPlayStoreFallback(context);
      }
    } catch (_) {
      // Any error from the In-App Review API → fall back gracefully.
      await _openPlayStoreFallback(context);
    }
  }

  /// Opens the app's Play Store listing so the user can leave a review there.
  static Future<void> _openPlayStoreFallback(BuildContext context) async {
    try {
      await _inAppReview.openStoreListing();
    } catch (_) {
      // openStoreListing also failed (Google Play not installed, etc.).
      // Show a SnackBar with the URL so the user is not left stranded.
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'Could not open Google Play. Visit the link below to rate the app.'),
            action: SnackBarAction(
              label: 'Copy link',
              onPressed: () {
                // As a last resort, show the URL.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(_playStoreUrl)),
                );
              },
            ),
          ),
        );
      }
    }
  }
}
