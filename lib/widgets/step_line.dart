import 'package:flutter/material.dart';

import '../theme.dart';

class StepLine extends StatelessWidget {
  const StepLine({super.key});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var i = 0; i < 3; i++) ...[
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: i < 2 ? AppColors.green : Colors.white, shape: BoxShape.circle, border: Border.all(color: AppColors.green)),
          child: Text('${i + 1}', style: TextStyle(fontSize: 11, color: i < 2 ? Colors.white : AppColors.green, fontWeight: FontWeight.w700)),
        ),
        if (i < 2) Expanded(child: Container(height: 1, color: AppColors.green.withValues(alpha: .35))),
      ],
    ],
  );
}
