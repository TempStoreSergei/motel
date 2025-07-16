// lib/presentation/dashboard_screen/widgets/booking_details_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'glassmorphic_container.dart';
import 'adaptive_text.dart';

class BookingDetailsWidget extends StatelessWidget {
  const BookingDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailItem(context, 'Корпус', 'Люкс', CupertinoIcons.building_2_fill),
            const VerticalDivider(color: Colors.white24, indent: 8, endIndent: 8),
            _buildDetailItem(context, 'Комната', '1205', CupertinoIcons.bed_double_fill),
            const VerticalDivider(color: Colors.white24, indent: 8, endIndent: 8),
            _buildDetailItem(context, 'Койка', '01', CupertinoIcons.person_alt),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: scaleText(context, 28)),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(color: Colors.white70, fontSize: scaleText(context, 14))),
          Text(value, style: TextStyle(color: Colors.white, fontSize: scaleText(context, 22), fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}