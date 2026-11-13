import 'package:flutter/material.dart';

import '../models/shop_item.dart';
import '../theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({required this.item, required this.onAdd, super.key});

  final ShopItem item;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
    child: Row(
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(color: item.tint, borderRadius: BorderRadius.circular(14)),
          child: Icon(item.icon, size: 35, color: AppColors.green),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.category.toUpperCase(), style: const TextStyle(fontSize: 9, letterSpacing: 1, color: AppColors.muted)),
              const SizedBox(height: 5),
              Text(item.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.ink)),
              const SizedBox(height: 6),
              Text('\$${item.price.toStringAsFixed(0)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.green)),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: onAdd,
          style: IconButton.styleFrom(backgroundColor: const Color(0xFFF0F2EC)),
          icon: const Icon(Icons.add, color: AppColors.green),
          tooltip: 'Add to cart',
        ),
      ],
    ),
  );
}
