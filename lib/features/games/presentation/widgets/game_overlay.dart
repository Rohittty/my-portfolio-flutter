import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/games/presentation/widgets/dino_runner_game.dart';
import 'package:my_portfolio/features/games/presentation/widgets/code_builder_game.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay({super.key});

  @override
  State<GameOverlay> createState() => _GameOverlayState();
}

class _GameOverlayState extends State<GameOverlay> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Floating Toggle Button
        if (!_isOpen)
          Positioned(
            bottom: 32,
            right: 32,
            child: FloatingActionButton.extended(
              onPressed: () => setState(() => _isOpen = true),
              backgroundColor: AppTheme.neonAccent,
              icon: const Icon(Icons.gamepad, color: Colors.black),
              label: Text(
                "PLAY_GAME()",
                style: GoogleFonts.jetBrainsMono(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ).animate().scale(delay: 500.ms).shimmer(delay: 2.seconds),
          ),

        // Game Modal
        if (_isOpen)
          Positioned.fill(
            child: Container(
              color: Colors.black87,
              child: Stack(
                children: [
                  // Game Content - with padding for close button
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 80,
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.cardSurface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppTheme.neonAccent.withOpacity(0.5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.neonAccent.withOpacity(0.2),
                              blurRadius: 32,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                Container(
                                  color: AppTheme.darkBackground,
                                  child: TabBar(
                                    tabs: const [
                                      Tab(
                                        icon: Icon(Icons.directions_run),
                                        text: "Dino Runner",
                                      ),
                                      Tab(
                                        icon: Icon(Icons.code),
                                        text: "Code Builder",
                                      ),
                                    ],
                                    labelColor: AppTheme.neonAccent,
                                    unselectedLabelColor: Colors.white54,
                                    indicatorColor: AppTheme.neonAccent,
                                    labelStyle: GoogleFonts.jetBrainsMono(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: TabBarView(
                                    children: [
                                      DinoRunnerGame(),
                                      CodeBuilderGame(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Close Button - Always on top
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.5),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: () => setState(() => _isOpen = false),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28,
                        ),
                        tooltip: 'Close Game',
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn().scale(),
            ),
          ),
      ],
    );
  }
}
