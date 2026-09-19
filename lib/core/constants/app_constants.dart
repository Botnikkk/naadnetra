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
}
