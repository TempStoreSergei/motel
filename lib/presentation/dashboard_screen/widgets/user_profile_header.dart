// lib/presentation/dashboard_screen/widgets/user_profile_header.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motel/models/booking_data.dart';
import 'package:motel/presentation/helpers/adaptive_text.dart';
import 'package:motel/presentation/helpers/glassmorphic_container.dart';

class UserProfileHeader extends StatelessWidget {
  final BookingData bookingData;
  const UserProfileHeader({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
    // Сначала помещаем отчество в локальную переменную.
    // Это стандартная практика для работы с nullable-типами.
    final patronymic = bookingData.patronymic;

    return GlassmorphicContainer(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Добавил немного отступов
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
              backgroundColor: CupertinoColors.systemIndigo,
              child: Icon(CupertinoIcons.person_fill, color: Colors.white)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${bookingData.firstName} ${bookingData.lastName}',
                style: TextStyle(color: Colors.white, fontSize: scaleText(context, 18), fontWeight: FontWeight.bold),
              ),

              // --- ИСПРАВЛЕНИЕ ЗДЕСЬ ---
              // Теперь мы безопасно проверяем, что локальная переменная не null И не пустая.
              // Только после этого пытаемся ее отобразить.
              if (patronymic != null && patronymic.isNotEmpty)
                Text(
                  patronymic, // Используем безопасную локальную переменную
                  style: TextStyle(color: Colors.white70, fontSize: scaleText(context, 14)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}