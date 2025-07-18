import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'keyboard_notifier.dart';

class CustomKeyboard extends StatelessWidget {
  final Function(String) onKeyPressed;

  const CustomKeyboard({super.key, required this.onKeyPressed});

  @override
  Widget build(BuildContext context) {
    final List<List<String>> keys = [
      ['й', 'ц', 'у', 'к', 'е', 'н', 'г', 'ш', 'щ', 'з', 'х', 'ъ'],
      ['ф', 'ы', 'в', 'а', 'п', 'р', 'о', 'л', 'д', 'ж', 'э'],
      ['SHIFT', 'я', 'ч', 'с', 'м', 'и', 'т', 'ь', 'б', 'ю', 'BACKSPACE'],
      ['TAB', 'SPACE', 'LANG'],
    ];

    return Consumer<KeyboardNotifier>(
      builder: (context, notifier, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Column(
                children: keys.map((row) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: (row.contains('ф') || row.contains('я')) ? 36.0 : 0.0,
                      bottom: 12.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: row.map((key) {
                        return _buildKey(context, key, notifier.isShiftEnabled);
                      }).toList(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildKey(BuildContext context, String key, bool isShiftEnabled) {
    final bool isLetterKey = key.length == 1;
    final bool isSpaceKey = key == 'SPACE';
    final bool isTabOrLangKey = key == 'TAB' || key == 'LANG';

    final Color letterKeyColor = Colors.white.withOpacity(0.35);
    final Color specialKeyColor = Colors.black.withOpacity(0.25);

    Widget keyChild;
    switch (key) {
      case 'SHIFT':
        keyChild = Icon(CupertinoIcons.shift_fill, color: isShiftEnabled ? CupertinoColors.activeBlue : Colors.white, size: 28);
        break;
      case 'BACKSPACE':
        keyChild = const Icon(CupertinoIcons.delete_left_fill, color: Colors.white, size: 28);
        break;
      case 'SPACE':
        keyChild = const SizedBox();
        break;
      case 'TAB':
        keyChild = const Icon(CupertinoIcons.arrow_right_to_line, color: Colors.white, size: 28);
        break;
      case 'LANG':
        keyChild = const Icon(CupertinoIcons.globe, color: Colors.white, size: 28);
        break;
      default:
        final text = isShiftEnabled ? key.toUpperCase() : key.toLowerCase();
        keyChild = Text(text, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w400));
    }

    double keyWidth;
    if (isSpaceKey) keyWidth = 250.0;
    else if (isTabOrLangKey) keyWidth = 84.0;
    else keyWidth = 60.0;

    return Container(
      width: keyWidth,
      height: 60.0,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: isLetterKey ? letterKeyColor : specialKeyColor,
        shape: isLetterKey ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isLetterKey ? null : const BorderRadius.all(Radius.circular(50)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          highlightColor: Colors.white.withOpacity(0.2),
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(isLetterKey ? 30 : 50),
          onTap: () => onKeyPressed(key),
          child: Center(child: keyChild),
        ),
      ),
    );
  }
}