// lib/presentation/dashboard_screen/widgets/calendar_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'glassmorphic_container.dart';
import 'adaptive_text.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final monthName = DateFormat('MMMM', 'ru_RU').format(now).toUpperCase();

    return GlassmorphicContainer(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat('EEEE', 'ru_RU').format(now).toUpperCase(),
                  style: TextStyle(color: Colors.white70, fontSize: scaleText(context, 16)),
                ),
                Text(
                  now.day.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: scaleText(context, 72),
                      fontWeight: FontWeight.w200),
                ),
                Text('Нет событий', style: TextStyle(color: Colors.white, fontSize: scaleText(context, 18))),
              ],
            ),
          ),
          const VerticalDivider(color: Colors.white24),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(monthName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: scaleText(context, 14))),
                const SizedBox(height: 8),
                Expanded(child: _buildCalendarGrid(context, now)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid(BuildContext context, DateTime now) {
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final dayOfWeekOffset = firstDayOfMonth.weekday - 1;

    return GridView.builder(
      // <<< ИСПРАВЛЕНИЕ: Возвращаем обязательный параметр gridDelegate
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7, // 7 дней в неделе
        childAspectRatio: 1.2, // Соотношение сторон ячейки
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: daysInMonth + dayOfWeekOffset,
      itemBuilder: (context, index) {
        if (index < dayOfWeekOffset) {
          return const SizedBox.shrink(); // Пустое место до 1-го числа
        }
        final day = index - dayOfWeekOffset + 1;
        final isToday = day == now.day;
        return Center(
          child: CircleAvatar(
            radius: scaleText(context, 14),
            backgroundColor: isToday ? Colors.red : Colors.transparent,
            child: Text('$day',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: scaleText(context, 14),
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal)),
          ),
        );
      },
    );
  }
}