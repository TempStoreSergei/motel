// lib/presentation/payment_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motel/models/booking_data.dart';
import 'package:motel/presentation/helpers/adaptive_text.dart';
import 'package:motel/presentation/helpers/glassmorphic_container.dart';

class PaymentScreen extends StatefulWidget {
  final BookingData bookingData;
  const PaymentScreen({Key? key, required this.bookingData}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Логика для определения цен на услуги
  final Map<String, double> _servicePrices = {
    'Проживание': 1500.0,
    'Платная уборка комнаты': 500.0,
    'Внеплановая замена белья': 300.0,
    'Штраф за нарушение правил проживания': 2000.0,
    'Стоянка автотранспорта': 250.0,
    'Стирка': 200.0,
  };

  String _selectedPaymentMethod = 'Картой'; // Способ оплаты по умолчанию

  @override
  Widget build(BuildContext context) {
    // Получаем цену для выбранной услуги. Если услуга не найдена, цена будет 0.0
    final double amount = _servicePrices[widget.bookingData.selectedService] ?? 0.0;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/hostel_cozy_room.jpg'), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            // Кнопка "Назад"
            Positioned(
              top: screenSize.height * 0.05,
              left: screenSize.width * 0.05,
              child: GlassmorphicContainer(
                child: CupertinoButton(
                  padding: const EdgeInsets.all(10),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Icon(CupertinoIcons.back, color: Colors.white, size: 35),
                ),
              ),
            ),

            // Основной контент
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: screenSize.width * 0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. БЛОК: ИНФОРМАЦИЯ О ПОЛЬЗОВАТЕЛЕ
                    _buildInfoCard(
                      title: 'Плательщик',
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.person_fill, color: Colors.white, size: 30),
                          const SizedBox(width: 15),
                          Text(
                            '${widget.bookingData.firstName} ${widget.bookingData.lastName}',
                            style: TextStyle(color: Colors.white, fontSize: scaleText(context, 20), fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // 2. БЛОК: ДЕТАЛИ УСЛУГИ И СУММА
                    _buildInfoCard(
                      title: 'Детали платежа',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Услуга: ${widget.bookingData.selectedService}',
                            style: TextStyle(color: Colors.white70, fontSize: scaleText(context, 18)),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Сумма: ${amount.toStringAsFixed(2)} руб.',
                            style: TextStyle(color: Colors.white, fontSize: scaleText(context, 24), fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // 3. БЛОК: ВЫБОР СПОСОБА ОПЛАТЫ
                    _buildInfoCard(
                      title: 'Способ оплаты',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildPaymentMethodButton('Картой', CupertinoIcons.creditcard_fill),
                          _buildPaymentMethodButton('Наличными', CupertinoIcons.money_rubl_circle_fill),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Кнопка "Оплатить"
                    CupertinoButton(
                      color: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      onPressed: () {
                        // Здесь будет логика реальной оплаты
                        print('Оплата на сумму $amount руб. (${widget.bookingData.selectedService}) способом "$_selectedPaymentMethod"');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Оплата прошла успешно!')),
                        );
                        // Возвращаемся на 2 экрана назад, к самому началу
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      child: Text('Оплатить', style: TextStyle(fontSize: scaleText(context, 20), fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Виджет для карточек с информацией
  Widget _buildInfoCard({required String title, required Widget child}) {
    return GlassmorphicContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: scaleText(context, 16)),
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }

  // Виджет для кнопок выбора способа оплаты
  Widget _buildPaymentMethodButton(String method, IconData icon) {
    final bool isSelected = _selectedPaymentMethod == method;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedPaymentMethod = method;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(width: 10),
              Text(method, style: TextStyle(color: Colors.white, fontSize: scaleText(context, 16), fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}