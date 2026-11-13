import 'package:flutter/material.dart';

import '../models/shop_item.dart';
import '../theme.dart';

class CartRow extends StatelessWidget {
  const CartRow({required this.item, required this.quantity, required this.onChange, super.key});

  final ShopItem item;
  final int quantity;
  final void Function(ShopItem, int) onChange;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
    child: Row(
      children: [
        Container(
          width: 74,
          height: 78,
          decoration: BoxDecoration(color: item.tint, borderRadius: BorderRadius.circular(13)),
          child: Icon(item.icon, color: AppColors.green, size: 34),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink)),
              const SizedBox(height: 5),
              Text(item.category, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
              const SizedBox(height: 8),
              Text('\$${item.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.green)),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(onPressed: () => onChange(item, -1), icon: const Icon(Icons.remove_circle_outline), visualDensity: VisualDensity.compact),
            Text('$quantity', style: const TextStyle(fontWeight: FontWeight.w600)),
            IconButton(onPressed: () => onChange(item, 1), icon: const Icon(Icons.add_circle_outline), visualDensity: VisualDensity.compact),
          ],
        ),
      ],
    ),
  );
}
