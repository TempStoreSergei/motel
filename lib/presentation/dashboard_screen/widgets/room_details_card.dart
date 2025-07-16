// lib/presentation/dashboard_screen/widgets/room_details_card.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomDetailsCard extends StatelessWidget {
  final VoidCallback onTap;
  const RoomDetailsCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _getWidgetDecoration(context),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Размещение', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 8),
            Text('Корпус Люкс, № 1205', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _getWidgetDecoration(BuildContext context) {
  return BoxDecoration(
    color: Colors.black.withOpacity(0.3),
    borderRadius: BorderRadius.circular(24),
  );
}