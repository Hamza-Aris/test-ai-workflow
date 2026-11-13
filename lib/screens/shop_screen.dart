import 'package:flutter/material.dart';

import '../models/shop_item.dart';
import '../theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/header.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'checkout_screen.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final Map<ShopItem, int> _cart = {shopItems[0]: 1, shopItems[1]: 1};

  int get _count => _cart.values.fold(0, (a, b) => a + b);
  double get _subtotal => _cart.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  void _add(ShopItem item) => setState(() => _cart[item] = (_cart[item] ?? 0) + 1);

  void _change(ShopItem item, int delta) => setState(() {
    final next = (_cart[item] ?? 0) + delta;
    if (next <= 0) {
      _cart.remove(item);
    } else {
      _cart[item] = next;
    }
  });

  void _openCart() => Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => CartScreen(
        cart: _cart,
        subtotal: _subtotal,
        onChange: _change,
        onCheckout: _openCheckout,
        onShop: () => Navigator.of(context).pop(),
      ),
    ),
  );

  void _openCheckout() => Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (_) => CheckoutScreen(subtotal: _subtotal, count: _count)),
  );

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Column(
            children: [
              ShopHeader(count: _count, onCart: _openCart),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 14, 22, 30),
                  children: [
                    Container(
                      height: 210,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(color: AppColors.paleGreen, borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('THOUGHTFUL FINDS', style: TextStyle(fontSize: 10, letterSpacing: 1.7, color: AppColors.green, fontWeight: FontWeight.w700)),
                                const SizedBox(height: 12),
                                const Text('Make room\nfor the good.', style: TextStyle(fontSize: 30, height: 1.12, fontWeight: FontWeight.w600, color: AppColors.ink)),
                                const SizedBox(height: 12),
                                Text('Small things, made to last.', style: TextStyle(fontSize: 12, color: AppColors.ink.withValues(alpha: .65))),
                              ],
                            ),
                          ),
                          const Icon(Icons.spa_outlined, size: 88, color: Color(0xFF81917B)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        const Expanded(child: Text('Curated for you', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.ink))),
                        Text('${shopItems.length} ITEMS', style: const TextStyle(fontSize: 10, letterSpacing: 1, color: AppColors.muted, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 14),
                    for (final item in shopItems) ...[
                      ProductCard(item: item, onAdd: () => _add(item)),
                      const SizedBox(height: 12),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    bottomNavigationBar: ShopBottomNav(selected: 0, onSelected: (index) { if (index == 1) _openCart(); }),
  );
}
