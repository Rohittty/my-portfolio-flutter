import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/features/devops_projects/presentation/widgets/devops_project_card.dart';
import 'package:my_portfolio/features/devops_projects/presentation/widgets/infra_simulator.dart';

class DevOpsProjectsScreen extends ConsumerStatefulWidget {
  const DevOpsProjectsScreen({super.key});

  @override
  ConsumerState<DevOpsProjectsScreen> createState() =>
      _DevOpsProjectsScreenState();
}

class _DevOpsProjectsScreenState extends ConsumerState<DevOpsProjectsScreen> {
  final List<String> _filters = [
    "All",
    "Kubernetes",
    "AWS",
    "Azure",
    "CI/CD",
    "Monitoring",
  ];
  String _activeFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DevOps Projects"),
        backgroundColor: AppTheme.darkBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter System
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _activeFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(filter),
                      onSelected: (selected) {
                        setState(() => _activeFilter = filter);
                      },
                      backgroundColor: AppTheme.cardSurface,
                      selectedColor: AppTheme.devOpsPrimary.withOpacity(0.2),
                      checkmarkColor: AppTheme.devOpsPrimary,
                      labelStyle: TextStyle(
                        color: isSelected
                            ? AppTheme.devOpsPrimary
                            : Colors.white70,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? AppTheme.devOpsPrimary
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Gap(32),

            // Project Cards Grid
            // TODO: Implement Project Cards here
            Wrap(
              spacing: 24,
              runSpacing: 24,
              children: [
                const DevOpsProjectCard(
                  title: "K8s-Autoscaler",
                  uptime: "99.99%",
                  techStack: ["Go", "Kubernetes", "Prometheus"],
                ),
                const DevOpsProjectCard(
                  title: "AWS-Terraform-Modules",
                  uptime: "Stable",
                  techStack: ["HCL", "AWS", "GitHub Actions"],
                ),
                const DevOpsProjectCard(
                  title: "LogStream-Processor",
                  uptime: "99.95%",
                  techStack: ["Rust", "Kafka", "Elasticsearch"],
                ),
                const DevOpsProjectCard(
                  title: "Microservices-Mesh",
                  uptime: "99.9%",
                  techStack: ["Istio", "Envoy", "Docker"],
                ),
              ],
            ),

            const Gap(32),

            // Infrastructure Simulator Mini-Game
            Text(
              "Infrastructure Simulator",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Gap(16),
            InfraSimulator(),
          ],
        ),
      ),
    );
  }
}
