// lib/presentation/dashboard_screen/widgets/user_profile_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'glassmorphic_container.dart';
import 'adaptive_text.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      padding: EdgeInsets.symmetric(horizontal: scaleText(context, 16), vertical: scaleText(context, 12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
              radius: scaleText(context, 22),
              backgroundColor: CupertinoColors.systemIndigo,
              child: Icon(CupertinoIcons.person_fill, color: Colors.white, size: scaleText(context, 22))),
          SizedBox(width: scaleText(context, 12)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Гость', style: TextStyle(color: Colors.white70, fontSize: scaleText(context, 14))),
              Text('Иванов Иван', style: TextStyle(color: Colors.white, fontSize: scaleText(context, 18), fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}