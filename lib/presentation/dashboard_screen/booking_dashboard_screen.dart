import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:motel/models/booking_data.dart';
import 'package:motel/presentation/payment_screen.dart';
import 'package:motel/presentation/helpers/glassmorphic_container.dart';
import 'widgets/user_profile_header.dart';
import 'widgets/language_switcher_widget.dart';
import 'widgets/accommodation_tile.dart';
import 'widgets/cleaning_tile.dart';
import 'widgets/linen_change_tile.dart';
import 'widgets/penalty_tile.dart';
import 'widgets/parking_tile.dart';
import 'widgets/laundry_tile.dart';

class BookingDashboardScreen extends StatelessWidget {
  final BookingData bookingData;
  const BookingDashboardScreen({super.key, required this.bookingData});

  void _onServiceSelected(BuildContext context, String serviceName) {
    bookingData.selectedService = serviceName;
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (_) => PaymentScreen(bookingData: bookingData),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final serviceNames = [
      'Проживание', 'Платная уборка комнаты', 'Внеплановая замена белья',
      'Штраф за нарушение правил проживания', 'Стоянка автотранспорта', 'Стирка'
    ];

    final serviceTiles = [
      AccommodationTile(onTap: () => _onServiceSelected(context, serviceNames[0])),
      CleaningTile(onTap: () => _onServiceSelected(context, serviceNames[1])),
      LinenChangeTile(onTap: () => _onServiceSelected(context, serviceNames[2])),
      PenaltyTile(onTap: () => _onServiceSelected(context, serviceNames[3])),
      ParkingTile(onTap: () => _onServiceSelected(context, serviceNames[4])),
      LaundryTile(onTap: () => _onServiceSelected(context, serviceNames[5])),
    ];

    // Создаем наш единый блок контента с "идеальными" пропорциями.
    final contentBlock = Container(
      // Отступы теперь ВНУТРИ блока, чтобы создать внутреннее пространство,
      // а не пустоту вокруг него.
      padding: const EdgeInsets.all(25),
      width: 1020, // "Идеальная" ширина, определяющая пропорции
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlassmorphicContainer(
                child: CupertinoButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(CupertinoIcons.back, color: Colors.white, size: 35),
                ),
              ),
              UserProfileHeader(bookingData: bookingData),
            ],
          ),
          const SizedBox(height: 25),
          GridView.custom(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4,
              mainAxisSpacing: 25,
              crossAxisSpacing: 25,
              pattern: const [
                QuiltedGridTile(2, 2),
                QuiltedGridTile(1, 2),
                QuiltedGridTile(1, 2),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 1),
                QuiltedGridTile(1, 2),
              ],
            ),
            childrenDelegate: SliverChildListDelegate(serviceTiles),
          ),
          const SizedBox(height: 25),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LanguageSwitcherWidget(),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/hostel_cozy_room.jpg'),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          // SafeArea обеспечивает отступы от системных элементов (челка, нижняя полоса)
          // Мы НЕ добавляем лишних отступов здесь.
          child: Center(
            // FittedBox занимает всё доступное место в SafeArea
            // и масштабирует contentBlock, чтобы он влез, максимально
            // используя пространство.
            child: FittedBox(
              fit: BoxFit.contain,
              child: contentBlock,
            ),
          ),
        ),
      ),
    );
  }
}