import 'package:share_plus/share_plus.dart';
import '../core/constants/app_constants.dart';

class ShareService {
  ShareService._();

  static Future<void> shareApp() async {
    await Share.share(
      '${AppConstants.appName}\n\n'
      '${AppConstants.shareText}\n\n'
      'Download here:\n${AppConstants.playStoreUrl}',
      subject: AppConstants.appName,
    );
  }
}