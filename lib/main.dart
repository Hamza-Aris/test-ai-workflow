import 'package:flutter/material.dart';

void main() => runApp(const ShopApp());

const _ink = Color(0xFF20231F);
const _muted = Color(0xFF858A81);
const _green = Color(0xFF526B4D);
const _paper = Color(0xFFF7F7F2);

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Morrow Market',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _paper,
      colorScheme: ColorScheme.fromSeed(seedColor: _green),
      fontFamily: 'Roboto',
    ),
    home: const ShopHome(),
  );
}

class ShopItem {
  const ShopItem(this.name, this.category, this.price, this.icon, this.tint);
  final String name;
  final String category;
  final double price;
  final IconData icon;
  final Color tint;
}

const _items = [
  ShopItem(
    'Everyday Tote',
    'Accessories',
    34,
    Icons.shopping_bag_outlined,
    Color(0xFFE7E1D2),
  ),
  ShopItem(
    'Stoneware Mug',
    'Home goods',
    22,
    Icons.coffee_outlined,
    Color(0xFFE2E8DF),
  ),
  ShopItem(
    'Soft Knit Throw',
    'Home goods',
    68,
    Icons.weekend_outlined,
    Color(0xFFECE1D9),
  ),
];

class ShopHome extends StatefulWidget {
  const ShopHome({super.key});
  @override
  State<ShopHome> createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  final Map<ShopItem, int> _cart = {_items[0]: 1, _items[1]: 1};
  int get _count => _cart.values.fold(0, (a, b) => a + b);
  double get _subtotal =>
      _cart.entries.fold(0, (sum, e) => sum + e.key.price * e.value);

  void _add(ShopItem item) =>
      setState(() => _cart[item] = (_cart[item] ?? 0) + 1);
  void _change(ShopItem item, int delta) => setState(() {
    final next = (_cart[item] ?? 0) + delta;
    if (next <= 0) {
      _cart.remove(item);
    } else {
      _cart[item] = next;
    }
  });

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Column(
            children: [
              _Header(count: _count, onCart: _openCart),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(22, 14, 22, 30),
                  children: [
                    Container(
                      height: 210,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9EDE4),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'THOUGHTFUL FINDS',
                                  style: TextStyle(
                                    fontSize: 10,
                                    letterSpacing: 1.7,
                                    color: _green,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'Make room\nfor the good.',
                                  style: TextStyle(
                                    fontSize: 30,
                                    height: 1.12,
                                    fontWeight: FontWeight.w600,
                                    color: _ink,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Small things, made to last.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _ink.withValues(alpha: .65),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.spa_outlined,
                            size: 88,
                            color: Color(0xFF81917B),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Curated for you',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: _ink,
                            ),
                          ),
                        ),
                        Text(
                          '3 ITEMS',
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 1,
                            color: _muted,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    for (final item in _items) ...[
                      _ProductCard(item: item, onAdd: () => _add(item)),
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
    bottomNavigationBar: const _BottomNav(selected: 0),
  );

  void _openCart() => Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => CartPage(
        cart: _cart,
        subtotal: _subtotal,
        onChange: _change,
        onCheckout: _openCheckout,
      ),
    ),
  );
  void _openCheckout() => Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => CheckoutPage(subtotal: _subtotal, count: _count),
    ),
  );
}

class _Header extends StatelessWidget {
  const _Header({required this.count, required this.onCart});
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
          decoration: BoxDecoration(
            color: _green,
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(Icons.eco_outlined, color: Colors.white, size: 22),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'morrow',
            style: TextStyle(
              fontSize: 21,
              letterSpacing: -.7,
              fontWeight: FontWeight.w700,
              color: _ink,
            ),
          ),
        ),
        IconButton(
          onPressed: onCart,
          icon: Badge(
            isLabelVisible: count > 0,
            label: Text('$count'),
            child: const Icon(Icons.shopping_bag_outlined, color: _ink),
          ),
          tooltip: 'Shopping cart',
        ),
      ],
    ),
  );
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.item, required this.onAdd});
  final ShopItem item;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        Container(
          width: 76,
          height: 76,
          decoration: BoxDecoration(
            color: item.tint,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(item.icon, size: 35, color: _green),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.category.toUpperCase(),
                style: const TextStyle(
                  fontSize: 9,
                  letterSpacing: 1,
                  color: _muted,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '\$${item.price.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: _green,
                ),
              ),
            ],
          ),
        ),
        IconButton.filledTonal(
          onPressed: onAdd,
          style: IconButton.styleFrom(backgroundColor: const Color(0xFFF0F2EC)),
          icon: const Icon(Icons.add, color: _green),
          tooltip: 'Add to cart',
        ),
      ],
    ),
  );
}

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    required this.cart,
    required this.subtotal,
    required this.onChange,
    required this.onCheckout,
  });
  final Map<ShopItem, int> cart;
  final double subtotal;
  final void Function(ShopItem, int) onChange;
  final VoidCallback onCheckout;
  @override
  Widget build(BuildContext context) {
    const shipping = 5.00;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your bag',
          style: TextStyle(fontWeight: FontWeight.w700, color: _ink),
        ),
        backgroundColor: _paper,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: cart.isEmpty
              ? const Center(
                  child: Text('Your bag is waiting for something lovely.'),
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(22, 10, 22, 24),
                  children: [
                    Text(
                      '${cart.values.fold(0, (a, b) => a + b)} items saved for you',
                      style: const TextStyle(color: _muted, fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    for (final entry in cart.entries) ...[
                      _CartRow(
                        item: entry.key,
                        quantity: entry.value,
                        onChange: onChange,
                      ),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        children: [
                          _PriceRow(
                            label: 'Subtotal',
                            value: '\$${subtotal.toStringAsFixed(2)}',
                          ),
                          const SizedBox(height: 12),
                          const _PriceRow(label: 'Shipping', value: '\$5.00'),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Divider(height: 1),
                          ),
                          _PriceRow(
                            label: 'Total',
                            value:
                                '\$${(subtotal + shipping).toStringAsFixed(2)}',
                            strong: true,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Shipping calculated for your order',
                            style: TextStyle(fontSize: 11, color: _muted),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 54,
                      child: FilledButton(
                        onPressed: onCheckout,
                        style: FilledButton.styleFrom(
                          backgroundColor: _green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Continue to checkout',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Continue shopping',
                        style: TextStyle(color: _green),
                      ),
                    ),
                  ],
                ),
        ),
      ),
      bottomNavigationBar: const _BottomNav(selected: 1),
    );
  }
}

class _CartRow extends StatelessWidget {
  const _CartRow({
    required this.item,
    required this.quantity,
    required this.onChange,
  });
  final ShopItem item;
  final int quantity;
  final void Function(ShopItem, int) onChange;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      children: [
        Container(
          width: 74,
          height: 78,
          decoration: BoxDecoration(
            color: item.tint,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(item.icon, color: _green, size: 34),
        ),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                item.category,
                style: const TextStyle(fontSize: 11, color: _muted),
              ),
              const SizedBox(height: 8),
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _green,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => onChange(item, -1),
              icon: const Icon(Icons.remove_circle_outline),
              visualDensity: VisualDensity.compact,
            ),
            Text(
              '$quantity',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            IconButton(
              onPressed: () => onChange(item, 1),
              icon: const Icon(Icons.add_circle_outline),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ],
    ),
  );
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.strong = false,
  });
  final String label, value;
  final bool strong;
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            fontSize: strong ? 15 : 13,
            color: strong ? _ink : _muted,
            fontWeight: strong ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: strong ? 16 : 13,
          color: _ink,
          fontWeight: strong ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    ],
  );
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key, required this.subtotal, required this.count});
  final double subtotal;
  final int count;
  @override
  Widget build(BuildContext context) {
    const total = 5.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.w700, color: _ink),
        ),
        backgroundColor: _paper,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
            children: [
              const _StepLine(),
              const SizedBox(height: 28),
              const Text(
                'Delivery details',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 14),
              const _DetailCard(
                icon: Icons.location_on_outlined,
                label: 'DELIVERING TO',
                title: 'Alex Morgan',
                detail: '24 Garden Lane, Brooklyn, NY 11211',
                action: 'Edit',
              ),
              const SizedBox(height: 12),
              const _DetailCard(
                icon: Icons.local_shipping_outlined,
                label: 'DELIVERY METHOD',
                title: 'Standard delivery',
                detail: 'Arrives in 3–5 business days',
                action: 'Change',
              ),
              const SizedBox(height: 12),
              const _DetailCard(
                icon: Icons.credit_card_outlined,
                label: 'PAYMENT',
                title: 'Visa ending in 4242',
                detail: 'Billing address same as delivery',
                action: 'Edit',
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _PriceRow(
                      label: 'Items ($count)',
                      value: '\$${subtotal.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 12),
                    const _PriceRow(label: 'Shipping', value: '\$5.00'),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Divider(height: 1),
                    ),
                    _PriceRow(
                      label: 'Total due',
                      value: '\$${(subtotal + total).toStringAsFixed(2)}',
                      strong: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 54,
                child: FilledButton(
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Order confirmed'),
                      content: const Text(
                        'Thanks for shopping with Morrow. Your order is on its way.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          },
                          child: const Text('Done'),
                        ),
                      ],
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: _green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Place order',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Secure checkout  ·  Free returns within 30 days',
                  style: TextStyle(fontSize: 10, color: _muted),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNav(selected: 1),
    );
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine();
  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var i = 0; i < 3; i++) ...[
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: i < 2 ? _green : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: _green),
          ),
          child: Text(
            '${i + 1}',
            style: TextStyle(
              fontSize: 11,
              color: i < 2 ? Colors.white : _green,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        if (i < 2)
          Expanded(
            child: Container(height: 1, color: _green.withValues(alpha: .35)),
          ),
      ],
    ],
  );
}

class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.icon,
    required this.label,
    required this.title,
    required this.detail,
    required this.action,
  });
  final IconData icon;
  final String label, title, detail, action;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2EC),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(icon, color: _green, size: 19),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 9,
                  letterSpacing: 1,
                  color: _muted,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(detail, style: const TextStyle(fontSize: 11, color: _muted)),
            ],
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            fontSize: 11,
            color: _green,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.selected});
  final int selected;
  @override
  Widget build(BuildContext context) => NavigationBar(
    height: 66,
    selectedIndex: selected,
    backgroundColor: Colors.white,
    indicatorColor: const Color(0xFFE9EDE4),
    onDestinationSelected: (index) {
      if (index == 1 && selected == 0) {
        final state = context.findAncestorStateOfType<_ShopHomeState>();
        state?._openCart();
      } else if (index == 0 && selected == 1) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    },
    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.storefront_outlined),
        selectedIcon: Icon(Icons.storefront),
        label: 'Shop',
      ),
      NavigationDestination(
        icon: Icon(Icons.shopping_bag_outlined),
        selectedIcon: Icon(Icons.shopping_bag),
        label: 'Bag',
      ),
    ],
  );
}
