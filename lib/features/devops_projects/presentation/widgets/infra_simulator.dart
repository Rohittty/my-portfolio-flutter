import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/theme/app_theme.dart';

class InfraSimulator extends StatefulWidget {
  const InfraSimulator({super.key});

  @override
  State<InfraSimulator> createState() => _InfraSimulatorState();
}

class _InfraSimulatorState extends State<InfraSimulator> {
  final List<NodeData> _nodes = [
    NodeData(id: 1, name: "Worker-01", load: 0.1, containers: []),
    NodeData(id: 2, name: "Worker-02", load: 0.2, containers: []),
    NodeData(id: 3, name: "Worker-03", load: 0.05, containers: []),
  ];

  void _onDrop(int nodeId, String containerType) {
    setState(() {
      final node = _nodes.firstWhere((n) => n.id == nodeId);
      node.containers.add(containerType);
      node.load = (node.load + 0.1).clamp(0.0, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.darkerBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Drag Containers to Deploy",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Gap(16),
          // Drag Source Area
          Row(
            children: [
              _DraggableContainer(
                type: "nginx",
                icon: FontAwesomeIcons.server,
                color: Colors.green,
              ),
              const Gap(16),
              _DraggableContainer(
                type: "redis",
                icon: FontAwesomeIcons.database,
                color: Colors.red,
              ),
              const Gap(16),
              _DraggableContainer(
                type: "api",
                icon: FontAwesomeIcons.microchip,
                color: Colors.blue,
              ),
            ],
          ),
          const Gap(32),
          Text("Cluster Nodes", style: Theme.of(context).textTheme.bodyLarge),
          const Gap(16),
          // Drop Target Area
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _nodes.length,
              separatorBuilder: (c, i) => const Gap(16),
              itemBuilder: (context, index) {
                return _NodeTarget(
                  node: _nodes[index],
                  onDrop: (type) => _onDrop(_nodes[index].id, type),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DraggableContainer extends StatelessWidget {
  final String type;
  final IconData icon;
  final Color color;

  const _DraggableContainer({
    required this.type,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      data: type,
      feedback: Transform.scale(
        scale: 1.1,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.cardSurface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 10)],
            border: Border.all(color: color),
          ),
          child: Icon(icon, color: color),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: _ContainerIcon(icon: icon, color: color, label: type),
      ),
      child: _ContainerIcon(icon: icon, color: color, label: type),
    );
  }
}

class _ContainerIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _ContainerIcon({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const Gap(8),
          Text(label, style: GoogleFonts.jetBrainsMono(fontSize: 10)),
        ],
      ),
    );
  }
}

class _NodeTarget extends StatelessWidget {
  final NodeData node;
  final Function(String) onDrop;

  const _NodeTarget({required this.node, required this.onDrop});

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      onAccept: onDrop,
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 160,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isHovered
                ? AppTheme.devOpsPrimary.withOpacity(0.1)
                : AppTheme.cardSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovered ? AppTheme.devOpsPrimary : Colors.white10,
              width: isHovered ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    node.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Icon(
                    FontAwesomeIcons.server,
                    size: 16,
                    color: Colors.white54,
                  ),
                ],
              ),
              const Gap(12),
              Text(
                "Load: ${(node.load * 100).toInt()}%",
                style: GoogleFonts.jetBrainsMono(fontSize: 12),
              ),
              const Gap(4),
              LinearProgressIndicator(
                value: node.load,
                backgroundColor: Colors.white10,
                color: node.load > 0.8 ? Colors.red : AppTheme.devOpsPrimary,
              ),
              const Gap(16),
              Expanded(
                child: Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: node.containers
                      .map(
                        (c) => Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.boxOpen,
                            size: 12,
                            color: Colors.white70,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class NodeData {
  final int id;
  final String name;
  double load;
  final List<String> containers;

  NodeData({
    required this.id,
    required this.name,
    required this.load,
    required this.containers,
  });
}
