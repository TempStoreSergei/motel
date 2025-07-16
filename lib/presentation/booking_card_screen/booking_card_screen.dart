// lib/presentation/booking_card_screen/booking_card_screen.dart

import 'package:flutter/cupertino.dart';
import '../../models/booking_model.dart';
import '../edit_dates_screen.dart';
import '../edit_guest_screen.dart';
import '../edit_room_screen.dart';
import 'widgets/interactive_booking_card.dart';

class BookingCardScreen extends StatefulWidget {
  const BookingCardScreen({super.key});

  @override
  State<BookingCardScreen> createState() => _BookingCardScreenState();
}

class _BookingCardScreenState extends State<BookingCardScreen> {
  late BookingModel _bookingModel;

  @override
  void initState() {
    super.initState();
    // Инициализируем модель с данными по умолчанию
    _bookingModel = BookingModel(
      arrivalDate: DateTime.now(),
      departureDate: DateTime.now().add(const Duration(days: 7)),
      roomNumber: [1, 2, 0, 5],
      bedNumber: [0, 1],
    );
  }

  // Навигация на экран редактирования гостя
  void _editGuestDetails() async {
    final result = await Navigator.of(context).push<BookingModel>(
      CupertinoPageRoute(
        builder: (context) => EditGuestScreen(initialBooking: _bookingModel),
      ),
    );
    if (result != null) {
      setState(() {
        _bookingModel = result;
      });
    }
  }

  // Навигация на экран редактирования дат
  void _editDates() async {
    final result = await Navigator.of(context).push<BookingModel>(
      CupertinoPageRoute(
        builder: (context) => EditDatesScreen(initialBooking: _bookingModel),
      ),
    );
    if (result != null) {
      setState(() {
        _bookingModel = result;
      });
    }
  }

  // Навигация на экран редактирования комнаты
  void _editRoom() async {
    final result = await Navigator.of(context).push<BookingModel>(
      CupertinoPageRoute(
        builder: (context) => EditRoomScreen(initialBooking: _bookingModel),
      ),
    );
    if (result != null) {
      setState(() {
        _bookingModel = result;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Ваше бронирование'),
        backgroundColor: Color(0x4D000000), // Полупрозрачный фон
        border: null,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InteractiveBookingCard(
              booking: _bookingModel,
              onGuestTap: _editGuestDetails,
              onDatesTap: _editDates,
              onRoomTap: _editRoom,
            ),
            const SizedBox(height: 30),
            CupertinoButton.filled(
              child: const Text('Подтвердить и оплатить'),
              onPressed: () {
                showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('Отлично!'),
                      content: Text('Бронирование для гостя ${_bookingModel.guestFullName} на номер ${_bookingModel.roomNumberString} готово к подтверждению.'),
                      actions: [
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    )
                );
              },
            )
          ],
        ),
      ),
    );
  }
}