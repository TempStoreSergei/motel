// lib/presentation/booking_card_screen/widgets/interactive_booking_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; // <<< ИСПРАВЛЕНИЕ: Добавлен импорт Material для доступа к 'Colors'
import 'package:intl/intl.dart';
import '../../../models/booking_model.dart';

class InteractiveBookingCard extends StatelessWidget {
  final BookingModel booking;
  final VoidCallback onGuestTap;
  final VoidCallback onDatesTap;
  final VoidCallback onRoomTap;

  const InteractiveBookingCard({
    super.key,
    required this.booking,
    required this.onGuestTap,
    required this.onDatesTap,
    required this.onRoomTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd.MM.yy', 'ru_RU');

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF4A4E69), Color(0xFF22223B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // --- Верхняя часть (Лого и чип) ---
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MotelApp',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              Icon(CupertinoIcons.circle_grid_3x3_fill, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 30),

          // --- Секция гостя (кликабельная) ---
          GestureDetector(
            onTap: onGuestTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ГОСТЬ', style: TextStyle(color: Colors.white54, fontSize: 12)),
                const SizedBox(height: 4),
                Text(
                  booking.guestFullName,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          // --- Нижняя часть (Даты и Комната) ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // --- Секция дат (кликабельная) ---
              GestureDetector(
                onTap: onDatesTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('ДАТЫ', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      '${dateFormatter.format(booking.arrivalDate)} - ${dateFormatter.format(booking.departureDate)}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
              // --- Секция комнаты (кликабельная) ---
              GestureDetector(
                onTap: onRoomTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('КОМНАТА', style: TextStyle(color: Colors.white54, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      booking.roomNumberString,
                      style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}