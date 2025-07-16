// lib/presentation/edit_room_screen.dart

import 'package:flutter/cupertino.dart';
import '../../models/booking_model.dart';

class EditRoomScreen extends StatefulWidget {
  final BookingModel initialBooking;

  const EditRoomScreen({super.key, required this.initialBooking});

  @override
  _EditRoomScreenState createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  late List<int> _roomNumber;
  late List<int> _bedNumber;
  late int _buildingIndex;
  late int _serviceIndex;

  late List<FixedExtentScrollController> _roomScrollControllers;
  late List<FixedExtentScrollController> _bedScrollControllers;

  @override
  void initState() {
    super.initState();
    _roomNumber = List.from(widget.initialBooking.roomNumber);
    _bedNumber = List.from(widget.initialBooking.bedNumber);
    _buildingIndex = widget.initialBooking.buildingIndex;
    _serviceIndex = widget.initialBooking.serviceIndex;

    _roomScrollControllers = _roomNumber
        .map((digit) => FixedExtentScrollController(initialItem: digit))
        .toList();
    _bedScrollControllers = _bedNumber
        .map((digit) => FixedExtentScrollController(initialItem: digit))
        .toList();
  }

  // <<< ИСПРАВЛЕНИЕ: Убираем dispose, так как контроллеры теперь создаются в initState
  // и будут жить столько же, сколько и State. Фреймворк справится с ними.

  void _onDone() {
    final updatedBooking = BookingModel(
      firstName: widget.initialBooking.firstName,
      lastName: widget.initialBooking.lastName,
      patronymic: widget.initialBooking.patronymic,
      arrivalDate: widget.initialBooking.arrivalDate,
      departureDate: widget.initialBooking.departureDate,
      buildingIndex: _buildingIndex,
      serviceIndex: _serviceIndex,
      roomNumber: _roomNumber,
      bedNumber: _bedNumber,
    );
    Navigator.of(context).pop(updatedBooking);
  }

  Widget _buildPicker(List<FixedExtentScrollController> controllers, List<int> values) {
    return Container(
      height: 150,
      // Убираем цвет фона, так как секция теперь сама задаст правильный фон
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(controllers.length, (columnIndex) {
          return Expanded(
            child: CupertinoPicker(
              scrollController: controllers[columnIndex],
              itemExtent: 40.0,
              backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context),
              onSelectedItemChanged: (value) {
                setState(() {
                  values[columnIndex] = value;
                });
              },
              children: List.generate(10, (index) => Center(child: Text('$index'))),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Размещение'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('Готово'),
          onPressed: _onDone,
        ),
      ),
      child: SafeArea(
        // <<< ИСПРАВЛЕНИЕ: Полностью переработана структура тела виджета
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              header: const Text('Корпус'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: CupertinoSlidingSegmentedControl<int>(
                    groupValue: _buildingIndex,
                    onValueChanged: (value) => setState(() => _buildingIndex = value!),
                    children: const {
                      0: Text('Главный'),
                      1: Text('Люкс'),
                      2: Text('Уютный'),
                    },
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('Услуга'),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: CupertinoSlidingSegmentedControl<int>(
                    groupValue: _serviceIndex,
                    onValueChanged: (value) => setState(() => _serviceIndex = value!),
                    children: const {
                      0: Text('Стандарт'),
                      1: Text('VIP'),
                    },
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('Номер комнаты'),
              children: [_buildPicker(_roomScrollControllers, _roomNumber)],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('Номер койко-места (2 цифры)'),
              children: [_buildPicker(_bedScrollControllers, _bedNumber)],
            ),
          ],
        ),
      ),
    );
  }
}