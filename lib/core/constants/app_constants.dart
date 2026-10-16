class AppConstants {
  AppConstants._();
  static const String appNameShort = 'NaadNetra';

  static const String appName = '$appNameShort AI';
  static String get appNameUpper => appName.toUpperCase();
  static String get appNameShortUpper => appNameShort.toUpperCase();

  static const String appTagline = 'Real-Time Voice Clone Defense';
  static const String appTaglineFull = '$appTagline System';

  static const double safeThreshold = 0.4;
  static const double cautionThreshold = 0.7;

  // The APK is published on the GitHub Pages site (not github.com), so the
  // GitHub Android app can't hijack the download link.
  static const String siteUrl = 'https://botnikkk.github.io/naadnetra';
  static const String apkDownloadUrl = '$siteUrl/naadnetra.apk';
  static const String versionUrl = '$siteUrl/version.json';
}