import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';

class ResponsiveService {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppConstants.tabletBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppConstants.tabletBreakpoint &&
      MediaQuery.of(context).size.width < AppConstants.desktopBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;

  static T responsiveValue<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    required T desktop,
  }) {
    final width = MediaQuery.of(context).size.width;

    if (width >= AppConstants.desktopBreakpoint) {
      return desktop;
    } else if (width >= AppConstants.tabletBreakpoint) {
      return tablet ?? desktop;
    } else {
      return mobile;
    }
  }
}
