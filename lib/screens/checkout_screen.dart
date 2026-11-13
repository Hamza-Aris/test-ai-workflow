import 'package:flutter/material.dart';

import '../theme.dart';
import '../widgets/detail_card.dart';
import '../widgets/price_row.dart';
import '../widgets/step_line.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.subtotal, required this.count});

  final double subtotal;
  final int count;

  void _showConfirmation(BuildContext context) => showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Order confirmed'),
      content: const Text('Thanks for shopping with Morrow. Your order is on its way.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(dialogContext);
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: const Text('Done'),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    const shipping = 5.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.ink)), backgroundColor: AppColors.paper, surfaceTintColor: Colors.transparent),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
            children: [
              const StepLine(),
              const SizedBox(height: 28),
              const Text('Delivery details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.ink)),
              const SizedBox(height: 14),
              const DetailCard(icon: Icons.location_on_outlined, label: 'DELIVERING TO', title: 'Alex Morgan', detail: '24 Garden Lane, Brooklyn, NY 11211', action: 'Edit'),
              const SizedBox(height: 12),
              const DetailCard(icon: Icons.local_shipping_outlined, label: 'DELIVERY METHOD', title: 'Standard delivery', detail: 'Arrives in 3–5 business days', action: 'Change'),
              const SizedBox(height: 12),
              const DetailCard(icon: Icons.credit_card_outlined, label: 'PAYMENT', title: 'Visa ending in 4242', detail: 'Billing address same as delivery', action: 'Edit'),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
                child: Column(
                  children: [
                    PriceRow(label: 'Items ($count)', value: '\$${subtotal.toStringAsFixed(2)}'),
                    const SizedBox(height: 12),
                    const PriceRow(label: 'Shipping', value: '\$5.00'),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 14), child: Divider(height: 1)),
                    PriceRow(label: 'Total due', value: '\$${(subtotal + shipping).toStringAsFixed(2)}', strong: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 54,
                child: FilledButton(
                  onPressed: () => _showConfirmation(context),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                  child: const Text('Place order', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 12),
              const Center(child: Text('Secure checkout  ·  Free returns within 30 days', style: TextStyle(fontSize: 10, color: AppColors.muted))),
              const SizedBox(height: 24),
              const _DeliveryOrderCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeliveryOrderCard extends StatelessWidget {
  const _DeliveryOrderCard();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('ORDER DELIVERY', style: TextStyle(fontSize: 10, letterSpacing: 1, color: AppColors.muted, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        const Text('Your order is ready to be delivered.', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.ink)),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: FilledButton.icon(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delivery option selected.'))),
            icon: const Icon(Icons.local_shipping_outlined),
            label: const Text('Deliver order'),
            style: FilledButton.styleFrom(backgroundColor: AppColors.green, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
          ),
        ),
      ],
    ),
  );
}
