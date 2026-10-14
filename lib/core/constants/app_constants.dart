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

  // GitHub repo that hosts the APK builds (Releases)
  static const String githubRepo = 'Botnikkk/naadnetra';
  static const String apkDownloadUrl =
      'https://github.com/$githubRepo/releases/latest/download/app-release.apk';
  static const String latestReleaseApiUrl =
      'https://api.github.com/repos/$githubRepo/releases/latest';
}