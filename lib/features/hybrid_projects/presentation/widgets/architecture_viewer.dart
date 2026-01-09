import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class ArchitectureViewer extends StatefulWidget {
  const ArchitectureViewer({super.key});

  @override
  State<ArchitectureViewer> createState() => _ArchitectureViewerState();
}

class _ArchitectureViewerState extends State<ArchitectureViewer> {
  bool _showCode = false;

  final String _terraformCode = '''
resource "aws_eks_cluster" "portfolio_cluster" {
  name     = "portfolio-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.public_subnet.id, aws_subnet.private_subnet.id]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
  ]
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  name                 = "portfolio_db"
  username             = "admin"
  password             = "securepassword"
}
''';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          // Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "System Architecture",
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      "Diagram",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: !_showCode ? Colors.white : Colors.white54,
                      ),
                    ),
                    Switch(
                      value: _showCode,
                      onChanged: (val) => setState(() => _showCode = val),
                      thumbColor: WidgetStateProperty.resolveWith((states) {
                        if (states.contains(WidgetState.selected)) {
                          return AppTheme.devOpsPrimary;
                        }
                        return AppTheme.flutterPrimary;
                      }),
                      inactiveTrackColor: Colors.white10,
                    ),
                    Text(
                      "IaC (Terraform)",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: _showCode ? Colors.white : Colors.white54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: _showCode
                ? SingleChildScrollView(
                    child: Text(
                      _terraformCode,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 14,
                        color: Colors.greenAccent,
                      ),
                    ).animate().fadeIn(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.hub, size: 64, color: Colors.white24),
                        const Gap(16),
                        Text(
                          "Architecture Diagram Visualization",
                          style: GoogleFonts.inter(color: Colors.white54),
                        ),
                        const Gap(8),
                        // Simulated diagram nodes
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _DiagramNode(Icons.phone_android, "Flutter App"),
                            _Arrow(),
                            _DiagramNode(Icons.cloud, "API Gateway"),
                            _Arrow(),
                            _DiagramNode(Icons.dns, "Microservices"),
                            _Arrow(),
                            _DiagramNode(Icons.storage, "Database"),
                          ],
                        ),
                      ],
                    ).animate().fadeIn(),
                  ),
          ),
        ],
      ),
    );
  }
}

class _DiagramNode extends StatelessWidget {
  final IconData icon;
  final String label;

  const _DiagramNode(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white10,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24),
          ),
          child: Icon(icon, color: Colors.white70),
        ),
        const Gap(8),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 10, color: Colors.white54),
        ),
      ],
    );
  }
}

class _Arrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 2,
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
}
