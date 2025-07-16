// lib/presentation/dashboard_screen/booking_dashboard_screen.dart
import 'package:flutter/material.dart';
import 'widgets/booking_details_widget.dart';
import 'widgets/calendar_widget.dart';
import 'widgets/fines_widget.dart';
import 'widgets/language_switcher_widget.dart';
import 'widgets/payment_button_widget.dart';
import 'widgets/quick_actions_widget.dart';
import 'widgets/user_profile_widget.dart';
import 'widgets/weather_widget.dart';

class BookingDashboardScreen extends StatelessWidget {
  const BookingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    final double horizontalPadding = screenWidth * 0.03;
    final double verticalPadding = screenHeight * 0.05;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/hotel_lobby.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // --- ВЕРХНЯЯ ПАНЕЛЬ ---
          Positioned(
            top: verticalPadding,
            left: horizontalPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.42,
                maxHeight: screenHeight * 0.38,
              ),
              child: const CalendarWidget(),
            ),
          ),
          Positioned(
            top: verticalPadding,
            right: horizontalPadding,
            child: const WeatherWidget(),
          ),

          // --- ЛЕВАЯ КОЛОНКА ---
          Positioned(
            top: screenHeight * 0.48,
            left: horizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const UserProfileWidget(),
                SizedBox(height: screenHeight * 0.02),
                const BookingDetailsWidget(),
              ],
            ),
          ),

          // <<< ИЗМЕНЕНИЕ: Размещаем виджет штрафов СПРАВА, а не в центре
          Positioned(
            top: screenHeight * 0.55, // Вертикально примерно по центру
            right: horizontalPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenWidth * 0.4),
              child: const FinesWidget(),
            ),
          ),

          // --- НИЖНЯЯ ПАНЕЛЬ УПРАВЛЕНИЯ ---
          Positioned(
            bottom: verticalPadding,
            left: horizontalPadding,
            child: const LanguageSwitcherWidget(),
          ),
          Positioned(
            bottom: verticalPadding,
            left: 0,
            right: 0,
            child: const Center(child: QuickActionsWidget()),
          ),
          Positioned(
            bottom: verticalPadding,
            right: horizontalPadding,
            child: const PaymentButtonWidget(),
          ),
        ],
      ),
    );
  }
}