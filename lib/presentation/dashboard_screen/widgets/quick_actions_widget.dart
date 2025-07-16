// lib/presentation/dashboard_screen/widgets/quick_actions_widget.dart
import 'package:flutter/cupertino.dart';
import 'glassmorphic_container.dart';
import 'adaptive_text.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      padding: EdgeInsets.symmetric(horizontal: scaleText(context, 16), vertical: scaleText(context, 10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ActionButton(icon: CupertinoIcons.wifi),
          SizedBox(width: scaleText(context, 18)),
          _ActionButton(icon: CupertinoIcons.bell_fill),
          SizedBox(width: scaleText(context, 18)),
          _ActionButton(icon: CupertinoIcons.car_detailed),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  const _ActionButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      borderRadius: scaleText(context, 18),
      padding: EdgeInsets.all(scaleText(context, 16)),
      // <<< ИСПРАВЛЕНИЕ: Используем CupertinoColors.white
      child: Icon(icon, color: CupertinoColors.white, size: scaleText(context, 30)),
    );
  }
}