import 'package:flutter/material.dart';

class ShopBottomNav extends StatelessWidget {
  const ShopBottomNav({required this.selected, required this.onSelected, super.key});

  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => NavigationBar(
    height: 66,
    selectedIndex: selected,
    backgroundColor: Colors.white,
    indicatorColor: const Color(0xFFE9EDE4),
    onDestinationSelected: onSelected,
    destinations: const [
      NavigationDestination(icon: Icon(Icons.storefront_outlined), selectedIcon: Icon(Icons.storefront), label: 'Shop'),
      NavigationDestination(icon: Icon(Icons.shopping_bag_outlined), selectedIcon: Icon(Icons.shopping_bag), label: 'Bag'),
    ],
  );
}
