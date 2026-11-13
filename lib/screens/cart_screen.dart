import 'package:flutter/material.dart';

import '../models/shop_item.dart';
import '../theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/cart_row.dart';
import '../widgets/price_row.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.cart, required this.subtotal, required this.onChange, required this.onCheckout, required this.onShop});

  final Map<ShopItem, int> cart;
  final double subtotal;
  final void Function(ShopItem, int) onChange;
  final VoidCallback onCheckout;
  final VoidCallback onShop;

  @override
  Widget build(BuildContext context) {
    const shipping = 5.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Your bag', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)), backgroundColor: AppColors.paper, surfaceTintColor: Colors.transparent),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: cart.isEmpty
              ? const Center(child: Text('Your bag is waiting for something lovely.'))
              : ListView(
                  padding: const EdgeInsets.fromLTRB(22, 10, 22, 24),
                  children: [
                    Text('${cart.values.fold(0, (a, b) => a + b)} items saved for you', style: const TextStyle(color: AppColors.muted, fontSize: 13)),
                    const SizedBox(height: 16),
                    for (final entry in cart.entries) ...[
                      CartRow(item: entry.key, quantity: entry.value, onChange: onChange),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          PriceRow(label: 'Subtotal', value: '\$${subtotal.toStringAsFixed(2)}'),
                          const SizedBox(height: 12),
                          const PriceRow(label: 'Shipping', value: '\$5.00'),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Divider(height: 1)),
                          PriceRow(label: 'Total', value: '\$${(subtotal + shipping).toStringAsFixed(2)}', strong: true),
                          const SizedBox(height: 8),
                          const Text('Shipping calculated for your order', style: TextStyle(fontSize: 11, color: AppColors.muted)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 54,
                      child: FilledButton(
                        onPressed: onCheckout,
                        style: FilledButton.styleFrom(backgroundColor: AppColors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                        child: const Text('Continue to checkout', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(onPressed: onShop, child: const Text('Continue shopping', style: TextStyle(color: AppColors.green))),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: ShopBottomNav(selected: 1, onSelected: (index) { if (index == 0) onShop(); }),
    );
  }
}
