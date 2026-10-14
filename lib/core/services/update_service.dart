import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/app_constants.dart';

/// Checks the latest GitHub Release and, if it is newer than the installed
/// build, shows an "Update available" dialog that opens the APK download.
///
/// Release tags look like `v12` (the workflow run number), and the installed
/// app's build number is set to the same run number by
/// `flutter build apk --build-number=...`, so the check is a plain integer
/// comparison.
class UpdateService {
  UpdateService._();

  static bool _checkedThisSession = false;

  static Future<void> checkForUpdate(BuildContext context) async {
    // Sideload updates only make sense for the Android app.
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    if (_checkedThisSession) return;
    _checkedThisSession = true;

    try {
      final res = await http
          .get(
            Uri.parse(AppConstants.latestReleaseApiUrl),
            headers: {'Accept': 'application/vnd.github+json'},
          )
          .timeout(const Duration(seconds: 8));
      if (res.statusCode != 200) return;

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final tag = (data['tag_name'] as String?) ?? '';
      final latest = int.tryParse(tag.replaceFirst('v', '')) ?? 0;

      final info = await PackageInfo.fromPlatform();
      final current = int.tryParse(info.buildNumber) ?? 0;

      if (latest > current && context.mounted) {
        await _showUpdateDialog(context, latest: latest, current: current);
      }
    } catch (_) {
      // Offline, rate-limited or malformed response: never block the app.
    }
  }

  static Future<void> _showUpdateDialog(
    BuildContext context, {
    required int latest,
    required int current,
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update available'),
        content: Text(
          'A newer version of ${AppConstants.appNameShort} (build $latest) '
          'is available. You are on build $current.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Later'),
          ),
          FilledButton(
            onPressed: () {
              launchUrl(
                Uri.parse(AppConstants.apkDownloadUrl),
                mode: LaunchMode.externalApplication,
              );
              Navigator.of(ctx).pop();
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }
}