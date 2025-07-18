import 'package:flutter/material.dart';
import 'package:motel/presentation/helpers/glassmorphic_container.dart';
import 'package:motel/presentation/helpers/adaptive_text.dart';

// Простая модель для хранения данных о языке
class Language {
  final String code;
  final String flag;

  const Language({required this.code, required this.flag});
}

class LanguageSwitcherWidget extends StatefulWidget {
  // Убираем const из конструктора StatefulWidget
  const LanguageSwitcherWidget({super.key});

  @override
  State<LanguageSwitcherWidget> createState() => _LanguageSwitcherWidgetState();
}

class _LanguageSwitcherWidgetState extends State<LanguageSwitcherWidget> {
  static const List<Language> _languages = [
    Language(code: 'RU', flag: '🇷🇺'),
    Language(code: 'UZ', flag: '🇺🇿'),
    Language(code: 'TJ', flag: '🇹🇯'),
    Language(code: 'TM', flag: '🇹🇲'),
  ];

  Language _selectedLanguage = _languages.first;
  OverlayEntry? _overlayEntry;
  final GlobalKey _buttonKey = GlobalKey();

  @override
  void dispose() {
    _closeMenu();
    super.dispose();
  }

  void _openMenu() {
    if (_overlayEntry != null) return;
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {});
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {});
  }

  void _onLanguageSelected(Language language) {
    setState(() {
      _selectedLanguage = language;
    });
    _closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _buttonKey,
      onTap: () {
        if (_overlayEntry == null) {
          _openMenu();
        } else {
          _closeMenu();
        }
      },
      child: GlassmorphicContainer(
        padding: EdgeInsets.symmetric(horizontal: scaleText(context, 12), vertical: scaleText(context, 8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_selectedLanguage.flag, style: TextStyle(fontSize: scaleText(context, 26))),
            SizedBox(width: scaleText(context, 8)),
            Text(_selectedLanguage.code, style: TextStyle(color: Colors.white54, fontSize: scaleText(context, 20))),
            const SizedBox(width: 4),
            Icon(
              _overlayEntry == null ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_down,
              color: Colors.white54,
              size: scaleText(context, 20),
            ),
          ],
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    final renderBox = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    final otherLanguages = _languages.where((lang) => lang.code != _selectedLanguage.code).toList();

    return OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(onTap: _closeMenu, child: Container(color: Colors.transparent)),
            ),
            Positioned(
              top: offset.dy,
              left: offset.dx + size.width + 8,
              // Ограничиваем максимальную ширину меню, чтобы избежать переполнения
              width: MediaQuery.of(context).size.width - (offset.dx + size.width + 16),
              child: Material(
                color: Colors.transparent,
                // ИСПРАВЛЕНИЕ: Используем Wrap вместо Row
                child: Wrap(
                  spacing: 8.0, // Горизонтальный отступ между элементами
                  runSpacing: 8.0, // Вертикальный отступ, если будет перенос на новую строку
                  children: otherLanguages
                      .map((lang) => GestureDetector(
                    onTap: () => _onLanguageSelected(lang),
                    child: GlassmorphicContainer(
                      padding: EdgeInsets.symmetric(horizontal: scaleText(context, 12), vertical: scaleText(context, 8)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Важно для Wrap
                        children: [
                          Text(lang.flag, style: TextStyle(fontSize: scaleText(context, 26))),
                          SizedBox(width: scaleText(context, 8)),
                          Text(lang.code, style: TextStyle(color: Colors.white54, fontSize: scaleText(context, 20))),
                        ],
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}