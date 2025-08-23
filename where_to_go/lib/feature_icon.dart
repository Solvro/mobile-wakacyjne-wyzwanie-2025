import "package:flutter/material.dart";

class FeatureIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const FeatureIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 40),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
