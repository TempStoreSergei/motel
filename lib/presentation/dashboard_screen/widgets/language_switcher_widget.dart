// lib/presentation/dashboard_screen/widgets/language_switcher_widget.dart
import 'package:flutter/material.dart';
import 'glassmorphic_container.dart';
import 'adaptive_text.dart';

class LanguageSwitcherWidget extends StatelessWidget {
  const LanguageSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      padding: EdgeInsets.symmetric(horizontal: scaleText(context, 12), vertical: scaleText(context, 8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🇷🇺', style: TextStyle(fontSize: scaleText(context, 26))),
          SizedBox(width: scaleText(context, 8)),
          Text('EN', style: TextStyle(color: Colors.white54, fontSize: scaleText(context, 20))),
        ],
      ),
    );
  }
}