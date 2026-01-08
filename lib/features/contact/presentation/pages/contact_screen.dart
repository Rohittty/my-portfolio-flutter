import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Node"),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                "> INITIALIZING_COMMUNICATION_PROTOCOL...",
                style: GoogleFonts.jetBrainsMono(color: Colors.greenAccent),
              ),
            ),
            const Gap(32),

            // Terminal Form
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.greenAccent.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.greenAccent.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "\$ enter_credentials",
                    style: GoogleFonts.jetBrainsMono(color: Colors.white54),
                  ),
                  const Gap(16),
                  _TerminalField(label: "user.name"),
                  const Gap(16),
                  _TerminalField(label: "user.email"),
                  const Gap(16),
                  Text(
                    "\$ enter_message",
                    style: GoogleFonts.jetBrainsMono(color: Colors.white54),
                  ),
                  const Gap(16),
                  _TerminalField(label: "message.body", maxLines: 5),
                  const Gap(24),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.greenAccent.withOpacity(0.1),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        "EXECUTE SEND()",
                        style: GoogleFonts.jetBrainsMono(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Gap(48),

            // Social Links
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 32,
              children: [
                _SocialLink(FontAwesomeIcons.github, "GitHub"),
                _SocialLink(FontAwesomeIcons.linkedin, "LinkedIn"),
                _SocialLink(FontAwesomeIcons.twitter, "Twitter"),
                _SocialLink(Icons.email, "Email"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TerminalField extends StatelessWidget {
  final String label;
  final int maxLines;

  const _TerminalField({required this.label, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "> $label",
          style: GoogleFonts.jetBrainsMono(color: Colors.greenAccent),
        ),
        const Gap(8),
        TextField(
          maxLines: maxLines,
          style: GoogleFonts.jetBrainsMono(color: Colors.white),
          cursorColor: Colors.greenAccent,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: InputBorder.none,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white10),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.greenAccent),
            ),
          ),
        ),
      ],
    );
  }
}

class _SocialLink extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialLink(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.white70),
        const Gap(8),
        Text(label, style: GoogleFonts.inter(color: Colors.white54)),
      ],
    );
  }
}
