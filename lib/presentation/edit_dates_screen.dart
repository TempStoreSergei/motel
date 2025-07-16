// lib/presentation/edit_dates_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../models/booking_model.dart';

class EditDatesScreen extends StatefulWidget {
  final BookingModel initialBooking;

  const EditDatesScreen({super.key, required this.initialBooking});

  @override
  _EditDatesScreenState createState() => _EditDatesScreenState();
}

class _EditDatesScreenState extends State<EditDatesScreen> {
  late DateTime _arrivalDate;
  late DateTime _departureDate;

  @override
  void initState() {
    super.initState();
    _arrivalDate = widget.initialBooking.arrivalDate;
    _departureDate = widget.initialBooking.departureDate;
  }

  void _onDone() {
    final updatedBooking = BookingModel(
      firstName: widget.initialBooking.firstName,
      lastName: widget.initialBooking.lastName,
      patronymic: widget.initialBooking.patronymic,
      arrivalDate: _arrivalDate,
      departureDate: _departureDate,
      buildingIndex: widget.initialBooking.buildingIndex,
      serviceIndex: widget.initialBooking.serviceIndex,
      roomNumber: widget.initialBooking.roomNumber,
      bedNumber: widget.initialBooking.bedNumber,
    );
    Navigator.of(context).pop(updatedBooking);
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('d MMMM yyyy', 'ru_RU');
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Даты пребывания'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Готово'),
          onPressed: _onDone,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoListSection.insetGrouped(
              header: const Text('Выберите даты'),
              children: [
                CupertinoListTile(
                  title: const Text('Дата приезда'),
                  trailing: Text(dateFormatter.format(_arrivalDate)),
                  onTap: () => _showDatePicker(context, isArrival: true),
                ),
                CupertinoListTile(
                  title: const Text('Дата отъезда'),
                  trailing: Text(dateFormatter.format(_departureDate)),
                  onTap: () => _showDatePicker(context, isArrival: false),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context, {required bool isArrival}) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 250,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          initialDateTime: isArrival ? _arrivalDate : _departureDate,
          minimumDate: isArrival ? DateTime.now() : _arrivalDate.add(const Duration(days: 1)),
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (newDate) {
            setState(() {
              if (isArrival) {
                _arrivalDate = newDate;
                if (_departureDate.isBefore(_arrivalDate) || _departureDate.isAtSameMomentAs(_arrivalDate)) {
                  _departureDate = _arrivalDate.add(const Duration(days: 1));
                }
              } else {
                _departureDate = newDate;
              }
            });
          },
        ),
      ),
    );
  }
}