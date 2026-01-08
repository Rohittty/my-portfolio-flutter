import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: 100,
          left: 32,
          right: 32,
          bottom: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The Engineering Journal",
              style: GoogleFonts.playfairDisplay(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ).animate().fadeIn().slideX(),
            const Gap(8),
            Text(
              "Thoughts on Flutter, DevOps, and the spaces in between.",
              style: GoogleFonts.inter(fontSize: 18, color: Colors.white54),
            ).animate().fadeIn(delay: 200.ms),
            const Gap(64),

            // Blog Grid
            Wrap(
              spacing: 32,
              runSpacing: 32,
              children: const [
                BlogCard(
                  title: "Scaling Flutter Apps with Riverpod",
                  excerpt:
                      "State management doesn't have to be a nightmare. Here is how to structure your app for millions of users.",
                  date: "Oct 12, 2023",
                  readTime: "5 min read",
                  tag: "Flutter",
                  color: Colors.blueAccent,
                ),
                BlogCard(
                  title: "Kubernetes for Mobile Developers",
                  excerpt:
                      "Why you should care about pods, services, and ingress even if you only write Dart.",
                  date: "Nov 04, 2023",
                  readTime: "8 min read",
                  tag: "DevOps",
                  color: Colors.purpleAccent,
                ),
                BlogCard(
                  title: "The Art of Micro-Animations",
                  excerpt:
                      "enhancing user experience without compromising performance using flutter_animate.",
                  date: "Dec 15, 2023",
                  readTime: "4 min read",
                  tag: "Design",
                  color: Colors.pinkAccent,
                ),
                BlogCard(
                  title: "Building a Portfolio that Stands Out",
                  excerpt:
                      "Lessons learned from redesigning my own site to be a digital architect's playground.",
                  date: "Jan 08, 2024",
                  readTime: "6 min read",
                  tag: "Career",
                  color: Colors.greenAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BlogCard extends StatefulWidget {
  final String title;
  final String excerpt;
  final String date;
  final String readTime;
  final String tag;
  final Color color;

  const BlogCard({
    super.key,
    required this.title,
    required this.excerpt,
    required this.date,
    required this.readTime,
    required this.tag,
    required this.color,
  });

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        width: 400,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.color.withOpacity(0.1)
              : Colors.white.withOpacity(0.02),
          border: Border(
            left: BorderSide(
              color: _isHovered ? widget.color : Colors.white10,
              width: 4,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.tag.toUpperCase(),
                  style: GoogleFonts.jetBrainsMono(
                    color: widget.color,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.date,
                  style: GoogleFonts.inter(color: Colors.white24, fontSize: 12),
                ),
              ],
            ),
            const Gap(16),
            Text(
              widget.title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.1,
              ),
            ),
            const Gap(12),
            Text(
              widget.excerpt,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white54,
                height: 1.5,
              ),
            ),
            const Gap(24),
            Row(
              children: [
                Text(
                  widget.readTime,
                  style: GoogleFonts.jetBrainsMono(
                    color: Colors.white30,
                    fontSize: 10,
                  ),
                ),
                const Spacer(),
                AnimatedOpacity(
                  opacity: _isHovered ? 1.0 : 0.0,
                  duration: 200.ms,
                  child: Row(
                    children: [
                      Text(
                        "Read Article",
                        style: GoogleFonts.inter(color: widget.color),
                      ),
                      const Gap(8),
                      Icon(Icons.arrow_forward, color: widget.color, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),
    );
  }
}
