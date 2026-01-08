import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class PackageShowcase extends StatelessWidget {
  const PackageShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PackageCard(
          name: "flutter_riverpod_extras",
          version: "v1.2.0",
          downloads: "12k+",
          description: "Additional utilities for Riverpod 2.0",
        ),
        const Gap(16),
        _PackageCard(
          name: "animate_on_scroll",
          version: "v0.5.4",
          downloads: "8.5k",
          description: "Trigger animations when widgets enter viewport",
        ),
      ],
    );
  }
}

class _PackageCard extends StatelessWidget {
  final String name;
  final String version;
  final String downloads;
  final String description;

  const _PackageCard({
    required this.name,
    required this.version,
    required this.downloads,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.flutterPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              FontAwesomeIcons.boxOpen,
              color: AppTheme.flutterPrimary,
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.flutterPrimary,
                      ),
                    ),
                    Text(
                      version,
                      style: GoogleFonts.inter(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Gap(16),
                Row(
                  children: [
                    Icon(Icons.download, size: 14, color: Colors.white54),
                    const Gap(4),
                    Text(
                      downloads,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                    const Spacer(),
                    TextButton.icon(
                      onPressed: () {}, // Can add url_launcher here
                      icon: const Icon(Icons.copy, size: 14),
                      label: const Text("pub add ..."),
                      style: TextButton.styleFrom(
                        foregroundColor: AppTheme.devOpsPrimary,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
