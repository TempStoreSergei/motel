// lib/presentation/dashboard_screen/widgets/payment_button_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adaptive_text.dart';

class PaymentButtonWidget extends StatelessWidget {
  const PaymentButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: scaleText(context, 250), // Задаем крупный, но адаптивный размер
      height: scaleText(context, 80),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(scaleText(context, 40)),
        gradient: const LinearGradient(
          colors: [Color(0xFF28B485), Color(0xFF7ED56F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF28B485).withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.creditcard_fill, color: Colors.white, size: scaleText(context, 28)),
            SizedBox(width: scaleText(context, 15)),
            Text(
              'Оплатить',
              style: TextStyle(
                color: Colors.white,
                fontSize: scaleText(context, 22),
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}