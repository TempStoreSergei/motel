// lib/presentation/dashboard_screen/widgets/dynamic_payment_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DynamicPaymentWidget extends StatelessWidget {
  const DynamicPaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [CupertinoColors.systemGreen, Color(0xFF1DB954)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.creditcard_fill, color: Colors.white, size: 36),
            SizedBox(height: 8),
            Text('Оплатить', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}