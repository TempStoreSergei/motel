// lib/presentation/guest_info/custom_keyboard.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motel/presentation/helpers/adaptive_text.dart';
import 'package:motel/presentation/helpers/glassmorphic_container.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  const CustomKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    // <<< ИЗМЕНЕНИЕ: Добавляем кнопку Tab "→"
    final keys = [
      ['й', 'ц', 'у', 'к', 'е', 'н', 'г', 'ш', 'щ', 'з', 'х', 'ъ'],
      ['ф', 'ы', 'в', 'а', 'п', 'р', 'о', 'л', 'д', 'ж', 'э'],
      ['→', 'я', 'ч', 'с', 'м', 'и', 'т', 'ь', 'б', 'ю', '⌫'],
    ];

    return GlassmorphicContainer(
      child: Column(
        children: keys.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: row.map((key) {
              final isSpecialKey = key == "⌫" || key == "→";
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Material(
                    color: isSpecialKey ? Colors.black.withOpacity(0.3) : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      onTap: () => onKeyPressed(key),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: scaleText(context, 50),
                        alignment: Alignment.center,
                        child: key == "→"
                            ? const Icon(CupertinoIcons.arrow_right_arrow_left, color: Colors.white)
                            : Text(key.toUpperCase(), style: TextStyle(color: Colors.white, fontSize: scaleText(context, 18), fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}