// lib/presentation/dashboard_screen/booking_dashboard_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'widgets/calendar_widget.dart';
import 'widgets/dynamic_payment_widget.dart';
import 'widgets/room_details_card.dart';
import 'widgets/user_profile_card.dart';

class BookingDashboardScreen extends StatelessWidget {
  const BookingDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // <<< ИЗМЕНЕНИЕ: Список виджетов и их размеров определен заранее для нового API
    final List<Widget> widgets = [
      const CalendarWidget(),
      UserProfileCard(onTap: () => print('Edit User')),
      RoomDetailsCard(onTap: () => print('Edit Room')),
      const DynamicPaymentWidget(),
    ];

    return CupertinoPageScaffold(
      child: Stack(
        children: [
          // Слой 1: Фоновое изображение
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Слой 2: Сетка виджетов
          SafeArea(
            // <<< ИЗМЕНЕНИЕ: Используем новый MasonryGridView.count
            child: MasonryGridView.count(
              padding: const EdgeInsets.all(16.0),
              crossAxisCount: 4, // Сетка все еще 4 колонки
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              itemCount: widgets.length,
              itemBuilder: (context, index) {
                // <<< ИЗМЕНЕНИЕ: Определяем размеры виджета прямо здесь
                int crossAxisCellCount;
                int mainAxisCellCount;

                switch (index) {
                  case 0: // Календарь
                    crossAxisCellCount = 4;
                    mainAxisCellCount = 2;
                    break;
                  case 1: // Пользователь
                    crossAxisCellCount = 2;
                    mainAxisCellCount = 1;
                    break;
                  case 2: // Комната
                    crossAxisCellCount = 2;
                    mainAxisCellCount = 1;
                    break;
                  case 3: // Оплата
                    crossAxisCellCount = 4;
                    mainAxisCellCount = 1;
                    break;
                  default:
                    crossAxisCellCount = 1;
                    mainAxisCellCount = 1;
                }

                // <<< ИЗМЕНЕНИЕ: Оборачиваем виджет в StaggeredGridTile
                return StaggeredGridTile.count(
                  crossAxisCellCount: crossAxisCellCount,
                  mainAxisCellCount: mainAxisCellCount,
                  child: widgets[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}