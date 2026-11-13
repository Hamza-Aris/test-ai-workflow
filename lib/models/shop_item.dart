import 'package:flutter/material.dart';

class ShopItem {
  const ShopItem(this.name, this.category, this.price, this.icon, this.tint);

  final String name;
  final String category;
  final double price;
  final IconData icon;
  final Color tint;
}

const shopItems = [
  ShopItem('Everyday Tote', 'Accessories', 34, Icons.shopping_bag_outlined, Color(0xFFE7E1D2)),
  ShopItem('Stoneware Mug', 'Home goods', 22, Icons.coffee_outlined, Color(0xFFE2E8DF)),
  ShopItem('Soft Knit Throw', 'Home goods', 68, Icons.weekend_outlined, Color(0xFFECE1D9)),
];
