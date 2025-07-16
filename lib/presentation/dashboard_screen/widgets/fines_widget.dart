// lib/presentation/dashboard_screen/widgets/fines_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'glassmorphic_container.dart';
import 'adaptive_text.dart';

class FinesWidget extends StatelessWidget {
  const FinesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: scaleText(context, 14),
                backgroundColor: CupertinoColors.systemRed,
                child: Icon(CupertinoIcons.exclamationmark_shield_fill, color: Colors.white, size: scaleText(context, 16)),
              ),
              SizedBox(width: scaleText(context, 12)),
              Text('Активные штрафы', style: TextStyle(color: Colors.white, fontSize: scaleText(context, 20), fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: scaleText(context, 16)),
          _buildFineItem(context, '2500 ₽', 'Отмена бронирования менее чем за 3 дня'),
          Divider(color: Colors.white24, height: scaleText(context, 24)),
          _buildFineItem(context, '5000 ₽', 'Повреждение имущества (мини-бар)'),
        ],
      ),
    );
  }

  Widget _buildFineItem(BuildContext context, String amount, String description) {
    return Row(
      children: [
        // <<< ИЗМЕНЕНИЕ: Оборачиваем текст в Expanded, чтобы он мог сжиматься и переноситься
        Expanded(
          child: Text(description, style: TextStyle(color: Colors.white, fontSize: scaleText(context, 18))),
        ),
        SizedBox(width: scaleText(context, 20)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: scaleText(context, 12), vertical: scaleText(context, 6)),
          decoration: BoxDecoration(
            color: CupertinoColors.systemRed,
            borderRadius: BorderRadius.circular(scaleText(context, 20)),
          ),
          child: Text(amount, style: TextStyle(color: Colors.white, fontSize: scaleText(context, 16), fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}