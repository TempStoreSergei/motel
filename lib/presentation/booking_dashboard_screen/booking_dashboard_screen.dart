// lib/presentation/booking_dashboard_screen/booking_dashboard_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../models/booking_model.dart';
import '../edit_dates_screen.dart';
import '../edit_guest_screen.dart';
import '../edit_room_screen.dart';
import 'widgets/animated_header.dart';
import 'widgets/dashboard_tile.dart';

class BookingDashboardScreen extends StatefulWidget {
  const BookingDashboardScreen({super.key});

  @override
  State<BookingDashboardScreen> createState() => _BookingDashboardScreenState();
}

class _BookingDashboardScreenState extends State<BookingDashboardScreen> {
  late BookingModel _bookingModel;
  final DateFormat _dateFormatter = DateFormat('d MMMM yyyy', 'ru_RU');

  @override
  void initState() {
    super.initState();
    _bookingModel = BookingModel(
      arrivalDate: DateTime.now().add(const Duration(days: 1)),
      departureDate: DateTime.now().add(const Duration(days: 8)),
    );
  }

  // <<< ИЗМЕНЕНИЕ: Навигационные методы теперь принимают Hero Tag
  void _editGuestDetails() async {
    final result = await Navigator.of(context).push<BookingModel>(
      CupertinoPageRoute(
        builder: (context) => EditGuestScreen(
          initialBooking: _bookingModel,
          heroTag: _bookingModel.guestHeroTag,
        ),
      ),
    );
    if (result != null) setState(() => _bookingModel = result);
  }

  void _editDates() async {
    final result = await Navigator.of(context).push<BookingModel>(
      CupertinoPageRoute(
        builder: (context) => EditDatesScreen(
          initialBooking: _bookingModel,
          heroTag: _bookingModel.datesHeroTag,
        ),
      ),
    );
    if (result != null) setState(() => _bookingModel = result);
  }

  void _editRoom() async {
    final result = await Navigator.of(context).push<BookingModel>(
      CupertinoPageRoute(
        builder: (context) => EditRoomScreen(
          initialBooking: _bookingModel,
          heroTag: _bookingModel.roomHeroTag,
        ),
      ),
    );
    if (result != null) setState(() => _bookingModel = result);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        // <<< ИЗМЕНЕНИЕ: ConstrainedBox для лучшего вида на очень широких экранах
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700), // Ограничение для iPad
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AnimatedHeader(serviceIndex: _bookingModel.serviceIndex),
                const SizedBox(height: 20),

                // <<< ИЗМЕНЕНИЕ: Использование Hero для плавной анимации перехода
                Hero(
                  tag: _bookingModel.guestHeroTag,
                  child: DashboardTile(
                    icon: CupertinoIcons.person_fill,
                    title: 'Гость',
                    subtitle: _bookingModel.guestFullName,
                    onTap: _editGuestDetails,
                  ),
                ),
                const SizedBox(height: 16),
                Hero(
                  tag: _bookingModel.datesHeroTag,
                  child: DashboardTile(
                    icon: CupertinoIcons.calendar,
                    title: 'Даты пребывания',
                    subtitle:
                    '${_dateFormatter.format(_bookingModel.arrivalDate)} - ${_dateFormatter.format(_bookingModel.departureDate)}',
                    onTap: _editDates,
                  ),
                ),
                const SizedBox(height: 16),
                Hero(
                  tag: _bookingModel.roomHeroTag,
                  child: DashboardTile(
                    icon: CupertinoIcons.building_2_fill,
                    title: 'Размещение',
                    subtitle: 'Корпус "${_bookingModel.buildingName}", комната ${_bookingModel.roomNumberString}',
                    onTap: _editRoom,
                  ),
                ),
                const SizedBox(height: 40),
                CupertinoButton.filled(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Text('Подтвердить бронирование', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  onPressed: () { /* ... */ },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}