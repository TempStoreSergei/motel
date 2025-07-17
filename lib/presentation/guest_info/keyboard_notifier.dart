// lib/presentation/guest_info/keyboard_notifier.dart
import 'package:flutter/material.dart';

class KeyboardNotifier extends ChangeNotifier {
  // <<< ИЗМЕНЕНИЕ: Теперь храним все контроллеры и отслеживаем индекс активного
  List<TextEditingController> controllers = [];
  int _activeIndex = -1;

  TextEditingController? get activeController => _activeIndex != -1 ? controllers[_activeIndex] : null;

  void registerControllers(List<TextEditingController> newControllers) {
    controllers = newControllers;
  }

  void setActiveControllerByIndex(int index) {
    if (index >= 0 && index < controllers.length) {
      _activeIndex = index;
      notifyListeners();
    }
  }

  void onKeyPressed(String key) {
    if (activeController == null) return;

    if (key == "⌫") {
      if (activeController!.text.isNotEmpty) {
        activeController!.text = activeController!.text.substring(0, activeController!.text.length - 1);
      }
    } else if (key == "→") { // <<< Логика для Tab
      _activeIndex = (_activeIndex + 1) % controllers.length;
      notifyListeners();
    } else {
      activeController!.text += key;
    }
  }

  // <<< Метод для проверки, активно ли данное поле
  bool isControllerActive(TextEditingController controller) {
    if (_activeIndex == -1) return false;
    return controllers[_activeIndex] == controller;
  }
}