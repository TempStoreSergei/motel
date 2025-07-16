// lib/presentation/dashboard_screen/widgets/weather_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'glassmorphic_container.dart';
import 'adaptive_text.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      padding: EdgeInsets.symmetric(horizontal: scaleText(context, 16), vertical: scaleText(context, 12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.sun_max_fill, color: Colors.yellow, size: scaleText(context, 32)),
          SizedBox(width: scaleText(context, 12)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Москва', style: TextStyle(color: Colors.white, fontSize: scaleText(context, 18), fontWeight: FontWeight.w600)),
              Text('+24° Ясно', style: TextStyle(color: Colors.white70, fontSize: scaleText(context, 14))),
            ],
          ),
        ],
      ),
    );
  }
}