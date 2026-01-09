import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class DevOpsProjectCard extends StatefulWidget {
  final String title;
  final String uptime;
  final List<String> techStack;

  const DevOpsProjectCard({
    super.key,
    required this.title,
    required this.uptime,
    required this.techStack,
  });

  @override
  State<DevOpsProjectCard> createState() => _DevOpsProjectCardState();
}

class _DevOpsProjectCardState extends State<DevOpsProjectCard> {
  // Simulate resource usage
  double _cpuLoad = 0.3;
  double _memoryLoad = 0.4;
  late Timer _timer;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          // Randomize slightly
          _cpuLoad =
              (_cpuLoad +
                      (0.1 -
                          (0.2 * (DateTime.now().millisecondsSinceEpoch % 2))))
                  .clamp(0.1, 0.9);
          _memoryLoad =
              (_memoryLoad +
                      (0.05 -
                          (0.1 * (DateTime.now().millisecondsSinceEpoch % 2))))
                  .clamp(0.2, 0.8);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Removed fixed width to allow LayoutBuilder/Flex to control sizing
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,

        decoration: BoxDecoration(
          color: AppTheme.cardSurface.withValues(alpha: _isHovered ? 0.9 : 0.7),
          borderRadius: BorderRadius.circular(16),
          // Neon Border
          border: Border.all(
            color: _isHovered
                ? AppTheme.devOpsPrimary
                : Colors.white.withValues(alpha: 0.1),
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: AppTheme.devOpsPrimary.withValues(alpha: 0.3),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            // Standard Flutter BackdropFilter
            // Standard Flutter BackdropFilter
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Important for Wrap/Masonry
              children: [
                // Header with Terminal Style
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.terminal,
                              size: 14,
                              color: AppTheme.devOpsPrimary.withValues(
                                alpha: 0.7,
                              ),
                            ),
                            const Gap(8),
                            Expanded(
                              child: Text(
                                "./${widget.title.toLowerCase().replaceAll(' ', '_')}.sh",
                                style: GoogleFonts.firaCode(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _StatusBadge(uptime: widget.uptime),
                    ],
                  ),
                ),

                // Main Content
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const Gap(16),

                      // Live Resource Monitor
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Column(
                          children: [
                            _ResourceBar(
                              label: "CPU_Load",
                              value: _cpuLoad,
                              color: AppTheme.devOpsPrimary,
                            ),
                            const Gap(8),
                            _ResourceBar(
                              label: "MEM_Usage",
                              value: _memoryLoad,
                              color: AppTheme.flutterPrimary,
                            ),
                          ],
                        ),
                      ),

                      const Gap(20),

                      // Tech Stack Chips
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.techStack
                            .map(
                              (tech) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.devOpsPrimary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppTheme.devOpsPrimary.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  tech,
                                  style: GoogleFonts.jetBrainsMono(
                                    color: AppTheme.devOpsPrimary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String uptime;
  const _StatusBadge({required this.uptime});

  @override
  Widget build(BuildContext context) {
    final isOnline =
        !uptime.toLowerCase().contains("down") &&
        !uptime.toLowerCase().contains("issue");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (isOnline ? AppTheme.neonAccent : Colors.red).withValues(
          alpha: 0.1,
        ),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: (isOnline ? AppTheme.neonAccent : Colors.red).withValues(
            alpha: 0.3,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
                Icons.circle,
                size: 6,
                color: isOnline ? AppTheme.neonAccent : Colors.red,
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .fade(duration: 1.seconds),
          const Gap(6),
          Text(
            uptime,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              color: isOnline ? AppTheme.neonAccent : Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ResourceBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _ResourceBar({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              color: Colors.white54,
            ),
          ),
        ),
        const Gap(8),
        Expanded(
          child: Stack(
            children: [
              // Track
              Container(
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Fill
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                widthFactor: value,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.5),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(12),
        SizedBox(
          width: 35,
          child: Text(
            "${(value * 100).toInt()}%",
            textAlign: TextAlign.end,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              color: Colors.white70,
            ),
          ),
        ),
      ],
    );
  }
}
