// lib/presentation/booking_dashboard_screen/widgets/animated_header.dart
import 'package:flutter/cupertino.dart';

class AnimatedHeader extends StatelessWidget {
  final int serviceIndex; // 0 for Standard, 1 for VIP

  const AnimatedHeader({super.key, required this.serviceIndex});

  @override
  Widget build(BuildContext context) {
    final bool isVip = serviceIndex == 1;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: isVip
              ? [const Color(0xFF6A11CB), const Color(0xFF2575FC)] // VIP Gradient
              : [const Color(0xFF434343), const Color(0xFF000000)], // Standard Gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: (isVip ? const Color(0xFF6A11CB) : Colors.black).withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Добро пожаловать',
            style: CupertinoTheme.of(context)
                .textTheme
                .navLargeTitleTextStyle
                .copyWith(color: CupertinoColors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Ваше бронирование почти готово. Проверьте и подтвердите детали ниже.',
            style: CupertinoTheme.of(context)
                .textTheme
                .textStyle
                .copyWith(color: CupertinoColors.lightBackgroundGray),
          ),
        ],
      ),
    );
  }
}