import 'package:flutter/material.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'dart:math';

class MobileSimulatorBackground extends StatefulWidget {
  const MobileSimulatorBackground({super.key});

  @override
  State<MobileSimulatorBackground> createState() =>
      _MobileSimulatorBackgroundState();
}

class _MobileSimulatorBackgroundState extends State<MobileSimulatorBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Very slow rotation for subtle effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _SimulatorPainter(
              animationValue: _controller.value,
              color: AppTheme.neonAccent.withValues(alpha: 0.05),
            ),
            size: Size.infinite,
          );
        },
      ),
    );
  }
}

class _SimulatorPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  _SimulatorPainter({required this.animationValue, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.02)
      ..style = PaintingStyle.fill;

    // Draw multiple "devices" floating
    _drawDevice(canvas, size, paint, fillPaint, 0.2, 0.2, 0.8);
    _drawDevice(canvas, size, paint, fillPaint, 0.8, 0.5, 0.6);
    _drawDevice(canvas, size, paint, fillPaint, 0.1, 0.8, 0.7);
    _drawDevice(canvas, size, paint, fillPaint, 0.9, 0.1, 0.5);
  }

  void _drawDevice(
    Canvas canvas,
    Size size,
    Paint borderPaint,
    Paint fillPaint,
    double xPercent,
    double yPercent,
    double scale,
  ) {
    final centerX = size.width * xPercent;
    final centerY = size.height * yPercent;

    // subtle float movement
    final floatY = sin(animationValue * 2 * pi + xPercent * 10) * 20;

    canvas.save();
    canvas.translate(centerX, centerY + floatY);
    canvas.rotate(
      0.1 * sin(animationValue * 2 * pi + yPercent * 10),
    ); // Slight tilt
    canvas.scale(scale);

    const width = 200.0;
    const height = 400.0;

    // Phone Body
    final bodyPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: width, height: height),
          const Radius.circular(30),
        ),
      );

    canvas.drawPath(bodyPath, fillPaint);
    canvas.drawPath(bodyPath, borderPaint);

    // Screen area
    final screenPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(
            center: Offset.zero,
            width: width - 20,
            height: height - 20,
          ),
          const Radius.circular(20),
        ),
      );
    canvas.drawPath(screenPath, borderPaint..strokeWidth = 0.5);

    // Dynamic Island / Notch
    final notchRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: const Offset(0, -180), width: 80, height: 25),
      const Radius.circular(20),
    );
    canvas.drawRRect(
      notchRect,
      fillPaint..color = borderPaint.color.withValues(alpha: 0.1),
    );

    // Abstract UI Lines (Code blocks)
    final uiPaint = Paint()
      ..color = borderPaint.color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 5; i++) {
      double yPos = -100.0 + (i * 40);
      double w = 100.0 + (sin(i * 99) * 40); // pseudo-random width
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(-60, yPos, w, 10),
          const Radius.circular(4),
        ),
        uiPaint,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_SimulatorPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}
