// lib/presentation/dashboard_screen/widgets/user_profile_card.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final VoidCallback onTap;
  const UserProfileCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onTap,
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: _getWidgetDecoration(context),
        child: const Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: CupertinoColors.systemIndigo,
              child: Icon(CupertinoIcons.person_fill, color: Colors.white),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Гость', style: TextStyle(color: Colors.white70)),
                  Text('Иванов Иван', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
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