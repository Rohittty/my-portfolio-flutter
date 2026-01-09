import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class InteractivePlayground extends StatefulWidget {
  const InteractivePlayground({super.key});

  @override
  State<InteractivePlayground> createState() => _InteractivePlaygroundState();
}

class _InteractivePlaygroundState extends State<InteractivePlayground> {
  double _borderRadius = 16.0;
  double _blur = 10.0;
  double _opacity = 0.2;
  bool _showGlow = true;

  String _generateCode() {
    return '''
Container(
  width: 200,
  height: 200,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(${_borderRadius.toInt()}),
    color: Colors.blue.withValues(alpha: ${_opacity.toStringAsFixed(2)}),
    ${_showGlow ? 'boxShadow: [\n      BoxShadow(\n        color: Colors.blue.withValues(alpha: 0.5),\n        blurRadius: 20,\n        spreadRadius: 5,\n      ),\n    ],' : ''}
  ),
  child: BackdropFilter(
    filter: ui.ImageFilter.blur(
      sigmaX: ${_blur.toInt()},
      sigmaY: ${_blur.toInt()},
    ),
    child: Center(
      child: Text(
        'Flutter',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
)''';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 900;

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white10),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
          ),
          child: Column(
            children: [
              // Toolbar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF252526),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    _WindowDot(Colors.red),
                    const SizedBox(width: 8),
                    _WindowDot(Colors.yellow),
                    const SizedBox(width: 8),
                    _WindowDot(Colors.green),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.science,
                      size: 16,
                      color: AppTheme.flutterPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "widget_lab.dart",
                      style: GoogleFonts.firaCode(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                          Icons.play_circle,
                          size: 18,
                          color: AppTheme.neonAccent,
                        )
                        .animate(onPlay: (c) => c.repeat())
                        .shimmer(duration: 2.seconds),
                    const SizedBox(width: 8),
                    Text(
                      "LIVE",
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: AppTheme.neonAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Main Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: isDesktop
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Code Editor
                          Expanded(flex: 3, child: _buildCodeEditor()),
                          const Gap(24),
                          // Preview
                          Expanded(flex: 2, child: _buildPreview()),
                        ],
                      )
                    : Column(
                        children: [
                          _buildPreview(),
                          const Gap(24),
                          _buildCodeEditor(),
                        ],
                      ),
              ),

              // Controls
              Container(
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: Color(0xFF252526),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "// WIDGET_CONTROLS",
                      style: GoogleFonts.firaCode(
                        color: Colors.white38,
                        fontSize: 12,
                      ),
                    ),
                    const Gap(16),
                    _buildSlider(
                      "Border Radius",
                      _borderRadius,
                      0,
                      50,
                      (v) => setState(() => _borderRadius = v),
                    ),
                    const Gap(12),
                    _buildSlider(
                      "Blur Intensity",
                      _blur,
                      0,
                      30,
                      (v) => setState(() => _blur = v),
                    ),
                    const Gap(12),
                    _buildSlider(
                      "Opacity",
                      _opacity,
                      0,
                      1,
                      (v) => setState(() => _opacity = v),
                    ),
                    const Gap(16),
                    Row(
                      children: [
                        Checkbox(
                          value: _showGlow,
                          onChanged: (v) =>
                              setState(() => _showGlow = v ?? true),
                          activeColor: AppTheme.flutterPrimary,
                        ),
                        Text(
                          "Enable Glow Effect",
                          style: GoogleFonts.inter(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCodeEditor() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: SingleChildScrollView(
        child: SelectableText(
          _generateCode(),
          style: GoogleFonts.jetBrainsMono(
            fontSize: 13,
            color: Colors.white,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: AppTheme.darkerBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.flutterPrimary.withValues(alpha: 0.3),
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            color: Colors.blue.withValues(alpha: _opacity),
            boxShadow: _showGlow
                ? [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(_borderRadius),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
              child: Center(
                child: Text(
                  'Flutter',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    ValueChanged<double> onChanged,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: GoogleFonts.inter(color: Colors.white70, fontSize: 13),
          ),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: min,
            max: max,
            activeColor: AppTheme.flutterPrimary,
            inactiveColor: Colors.white24,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            value.toStringAsFixed(1),
            textAlign: TextAlign.end,
            style: GoogleFonts.jetBrainsMono(
              color: AppTheme.flutterPrimary,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _WindowDot extends StatelessWidget {
  final Color color;
  const _WindowDot(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
