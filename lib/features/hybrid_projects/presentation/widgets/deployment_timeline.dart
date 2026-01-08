import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class DeploymentTimeline extends StatelessWidget {
  const DeploymentTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TimelineItem(
          date: "Q4 2023",
          title: "Microservices Migration",
          description:
              "Decomposed monolith into 12 Go microservices deployed on EKS.",
          color: Colors.blueAccent,
          isFirst: true,
        ),
        _TimelineItem(
          date: "Q1 2024",
          title: "Hybrid Mobile App Launch",
          description:
              "Released Flutter app with real-time WebSocket integration.",
          color: Colors.tealAccent,
        ),
        _TimelineItem(
          date: "Q2 2024",
          title: "Global Edge Deployment",
          description:
              "Implemented multi-region replication causing 40% latency drop.",
          color: Colors.orangeAccent,
          isLast: true,
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String date;
  final String title;
  final String description;
  final Color color;
  final bool isFirst;
  final bool isLast;

  const _TimelineItem({
    required this.date,
    required this.title,
    required this.description,
    required this.color,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Line & Dot
        Column(
          children: [
            Container(
              width: 2,
              height: 20,
              color: isFirst ? Colors.transparent : Colors.white24,
            ),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.5), blurRadius: 6),
                ],
              ),
            ),
            Container(
              width: 2,
              height: isLast ? 0 : 80, // Adjust height based on content
              color: isLast ? Colors.transparent : Colors.white24,
            ),
          ],
        ),
        const Gap(16),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 24),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.cardSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        date,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          color: color,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
