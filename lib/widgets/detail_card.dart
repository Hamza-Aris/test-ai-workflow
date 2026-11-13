import 'package:flutter/material.dart';

import '../theme.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({required this.icon, required this.label, required this.title, required this.detail, required this.action, super.key});

  final IconData icon;
  final String label;
  final String title;
  final String detail;
  final String action;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17)),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(color: const Color(0xFFF0F2EC), borderRadius: BorderRadius.circular(11)),
          child: Icon(icon, color: AppColors.green, size: 19),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 9, letterSpacing: 1, color: AppColors.muted)),
              const SizedBox(height: 6),
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.ink)),
              const SizedBox(height: 4),
              Text(detail, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
            ],
          ),
        ),
        Text(action, style: const TextStyle(fontSize: 11, color: AppColors.green, fontWeight: FontWeight.w600)),
      ],
    ),
  );
}
