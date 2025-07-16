// lib/presentation/dashboard_screen/widgets/calendar_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthName = DateFormat('MMMM', 'ru_RU').format(now).toUpperCase();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _getWidgetDecoration(context),
      child: Row(
        children: [
          // Левая часть: Дата
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EEEE', 'ru_RU').format(now).toUpperCase(),
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                Text(
                  now.day.toString(),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.w200),
                ),
                const Text(
                  'Нет событий',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          // Правая часть: Сетка календаря
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(monthName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildCalendarGrid(now),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(DateTime now) {
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    // 1=Пн, 7=Вс. Нам нужен отступ для сетки.
    final dayOfWeekOffset = firstDayOfMonth.weekday - 1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: daysInMonth + dayOfWeekOffset,
      itemBuilder: (context, index) {
        if (index < dayOfWeekOffset) {
          return const SizedBox.shrink(); // Пустое место до 1-го числа
        }
        final day = index - dayOfWeekOffset + 1;
        final isToday = day == now.day;

        return Center(
          child: CircleAvatar(
            radius: 14,
            backgroundColor: isToday ? Colors.red : Colors.transparent,
            child: Text(
              '$day',
              style: TextStyle(
                color: isToday ? Colors.white : Colors.white70,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Общая декорация для всех виджетов, чтобы стиль был единым
BoxDecoration _getWidgetDecoration(BuildContext context) {
  return BoxDecoration(
    color: Colors.black.withOpacity(0.3),
    borderRadius: BorderRadius.circular(24),
  );
}