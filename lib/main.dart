// lib/main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
// <<< ИЗМЕНЕНИЕ: Импортируем новый экран блокировки
import 'presentation/lock_screen/lock_screen.dart';

void main() {
  initializeDateFormatting('ru_RU', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('ru', 'RU')],
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      // <<< ИЗМЕНЕНИЕ: Стартуем с экрана блокировки
      home: LockScreen(),
    );
  }
}