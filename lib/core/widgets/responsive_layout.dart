import 'package:flutter/material.dart';
import 'package:my_portfolio/core/constants/app_constants.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget? tabletBody;
  final Widget desktopBody;

  const ResponsiveLayout({
    super.key,
    required this.mobileBody,
    this.tabletBody,
    required this.desktopBody,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppConstants.desktopBreakpoint) {
          return desktopBody;
        } else if (constraints.maxWidth >= AppConstants.tabletBreakpoint) {
          return tabletBody ?? desktopBody;
        } else {
          return mobileBody;
        }
      },
    );
  }
}
