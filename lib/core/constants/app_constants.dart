class AppConstants {
  // Breakpoints
  static const double mobileBreakpoint = 480;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1024;
  static const double largeDesktopBreakpoint = 1440;

  // Asset Paths
  static const String profileImageDevOps = 'assets/images/profile_devops.png';
  static const String profileImageFlutter = 'assets/images/profile_flutter.png';
  static const String techIconDocker = 'assets/icons/docker.png';
  static const String techIconKubernetes = 'assets/icons/k8s.png';
  static const String techIconFlutter = 'assets/icons/flutter.png';

  // Strings & Content
  static const String appTitle = 'Rohit | DevOps & Flutter Engineer';
  static const String heroTagline =
      'Building bridges between servers and screens.';
  static const String devOpsTitle = 'DevOps Engineer';
  static const String flutterTitle = 'Flutter Developer';

  // Navigation Routes
  static const String routeHome = '/';
  static const String routeDevOps = '/devops';
  static const String routeFlutter = '/flutter';
  static const String routeHybrid = '/hybrid';
  static const String routeAbout = '/about';
  static const String routeContact = '/contact';

  // Feature Flags
  static const bool enableKonamiCode = true;
  static const bool enableNightOps = true;
}
