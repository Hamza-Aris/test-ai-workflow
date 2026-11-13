import 'package:flutter/material.dart';

import '../theme.dart';

class ShopHeader extends StatelessWidget {
  const ShopHeader({required this.count, required this.onCart, super.key});

  final int count;
  final VoidCallback onCart;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(22, 14, 18, 8),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(13)),
          child: const Icon(Icons.eco_outlined, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text('morrow', style: TextStyle(fontSize: 21, letterSpacing: -.7, fontWeight: FontWeight.w700, color: AppColors.ink)),
        ),
        IconButton(
          onPressed: onCart,
          icon: Badge(isLabelVisible: count > 0, label: Text('$count'), child: const Icon(Icons.shopping_bag_outlined, color: AppColors.ink)),
          tooltip: 'Shopping cart',
        ),
      ],
    ),
  );
}
