import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class CodePlayground extends StatefulWidget {
  const CodePlayground({super.key});

  @override
  State<CodePlayground> createState() => _CodePlaygroundState();
}

class _CodePlaygroundState extends State<CodePlayground> {
  final String _codeSnippet = '''
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Hello Flutter")),
        body: Center(
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            child: Text("Hot Reload is Magic!"),
          ),
        ),
      ),
    );
  }
}
''';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // VS Code Dark
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
      ),
      child: Column(
        children: [
          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                const Icon(Icons.code, size: 16, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  "main.dart",
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
                ),
                const Spacer(),
                const Icon(
                  Icons.play_arrow,
                  size: 16,
                  color: Colors.greenAccent,
                ),
                const SizedBox(width: 8),
                Text(
                  "Run",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),

          // Editor Area
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Line Numbers
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(
                    _codeSnippet.split('\n').length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 2,
                      ), // Match TextStyle heightish
                      child: Text(
                        "${index + 1}",
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 14,
                          color: Colors.white24,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Code
                Expanded(
                  child:
                      Text(
                            _codeSnippet,
                            style: GoogleFonts.jetBrainsMono(
                              fontSize: 14,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          )
                          .animate()
                          .fadeIn(duration: 1.seconds)
                          .shimmer(duration: 2.seconds, delay: 1.seconds),
                ),
              ],
            ),
          ),
        ],
      ),
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
