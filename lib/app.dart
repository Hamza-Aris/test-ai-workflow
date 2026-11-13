import 'package:flutter/material.dart';

import 'screens/shop_screen.dart';
import 'theme.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Morrow Market',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.paper,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
      fontFamily: 'Roboto',
    ),
    home: const ShopScreen(),
  );
}
