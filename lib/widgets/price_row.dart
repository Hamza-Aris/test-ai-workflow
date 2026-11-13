import 'package:flutter/material.dart';

import '../theme.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({required this.label, required this.value, this.strong = false, super.key});

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(fontSize: strong ? 15 : 13, color: strong ? AppColors.ink : AppColors.muted, fontWeight: strong ? FontWeight.w700 : FontWeight.w400),
        ),
      ),
      Text(value, style: TextStyle(fontSize: strong ? 16 : 13, color: AppColors.ink, fontWeight: strong ? FontWeight.w700 : FontWeight.w500)),
    ],
  );
}
