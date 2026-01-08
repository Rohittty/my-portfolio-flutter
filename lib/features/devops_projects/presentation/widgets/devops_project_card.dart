import 'dart:async';
import 'package:flutter/material.dart';
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
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.server,
                      size: 16,
                      color: Colors.white70,
                    ),
                    const Gap(8),
                    Text(
                      widget.title,
                      style: GoogleFonts.jetBrainsMono(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                _StatusBadge(uptime: widget.uptime),
              ],
            ),
          ),

          // Body
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resource Graphs
                _ResourceBar(
                  label: "CPU",
                  value: _cpuLoad,
                  color: _cpuLoad > 0.8
                      ? Colors.redAccent
                      : AppTheme.devOpsPrimary,
                ),
                const Gap(8),
                _ResourceBar(
                  label: "MEM",
                  value: _memoryLoad,
                  color: _memoryLoad > 0.8
                      ? Colors.orangeAccent
                      : AppTheme.flutterPrimary,
                ),

                const Gap(16),
                const Divider(color: Colors.white10),
                const Gap(16),

                // Tech Stack Badges
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.techStack
                      .map(
                        (tech) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.white10),
                          ),
                          child: Text(
                            tech,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

                const Gap(16),
                Center(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.hub, size: 16),
                    label: const Text("View Architecture"),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.devOpsPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String uptime;
  const _StatusBadge({required this.uptime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.devOpsPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppTheme.devOpsPrimary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 8, color: AppTheme.devOpsPrimary),
          const Gap(4),
          Text(
            uptime,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              color: AppTheme.devOpsPrimary,
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
          width: 30,
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
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        const Gap(8),
        SizedBox(
          width: 30,
          child: Text(
            "${(value * 100).toInt()}%",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 10,
              color: Colors.white54,
            ),
          ),
        ),
      ],
    );
  }
}
