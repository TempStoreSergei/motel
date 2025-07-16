// lib/presentation/edit_guest_screen.dart

import 'package:flutter/cupertino.dart';
import '../../models/booking_model.dart';

class EditGuestScreen extends StatefulWidget {
  final BookingModel initialBooking;

  const EditGuestScreen({super.key, required this.initialBooking});

  @override
  _EditGuestScreenState createState() => _EditGuestScreenState();
}

class _EditGuestScreenState extends State<EditGuestScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _patronymicController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.initialBooking.firstName);
    _lastNameController = TextEditingController(text: widget.initialBooking.lastName);
    _patronymicController = TextEditingController(text: widget.initialBooking.patronymic);
  }

  void _onDone() {
    final updatedBooking = BookingModel(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      patronymic: _patronymicController.text,
      arrivalDate: widget.initialBooking.arrivalDate,
      departureDate: widget.initialBooking.departureDate,
      buildingIndex: widget.initialBooking.buildingIndex,
      serviceIndex: widget.initialBooking.serviceIndex,
      roomNumber: widget.initialBooking.roomNumber,
      bedNumber: widget.initialBooking.bedNumber,
    );
    Navigator.of(context).pop(updatedBooking);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Данные гостя'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Готово'),
          onPressed: _onDone,
        ),
      ),
      child: SafeArea(
        child: CupertinoListSection.insetGrouped(
          header: const Text('Введите данные гостя'),
          children: [
            CupertinoTextField(
              controller: _firstNameController,
              placeholder: 'Имя',
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(),
            ),
            CupertinoTextField(
              controller: _lastNameController,
              placeholder: 'Фамилия',
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(),
            ),
            CupertinoTextField(
              controller: _patronymicController,
              placeholder: 'Отчество',
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(),
            ),
          ],
        ),
      ),
    );
  }
}