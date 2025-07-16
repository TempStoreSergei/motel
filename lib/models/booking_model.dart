// lib/models/booking_model.dart
import 'package:flutter/widgets.dart';

class BookingModel {
  // <<< ИЗМЕНЕНИЕ: Уникальные ключи для Hero-анимаций
  final Object guestHeroTag = UniqueKey();
  final Object datesHeroTag = UniqueKey();
  final Object roomHeroTag = UniqueKey();

  String firstName;
  String lastName;
  String patronymic;
  DateTime arrivalDate;
  DateTime departureDate;
  int buildingIndex;
  int serviceIndex;
  List<int> roomNumber;
  List<int> bedNumber;

  BookingModel({
    this.firstName = 'Иван',
    this.lastName = 'Иванов',
    this.patronymic = 'Иванович',
    required this.arrivalDate,
    required this.departureDate,
    this.buildingIndex = 0,
    this.serviceIndex = 0,
    this.roomNumber = const [1, 2, 0, 5],
    this.bedNumber = const [0, 1],
  });

  // ... геттеры остаются без изменений ...
  String get guestFullName => '$lastName $firstName $patronymic'.trim();
  String get roomNumberString => roomNumber.join();
  String get bedNumberString => bedNumber.join();
  String get buildingName {
    const names = ['Главный', 'Люкс', 'Уютный'];
    return names[buildingIndex];
  }
}