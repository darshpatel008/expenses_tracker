import 'package:expenses_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

var KColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromRGBO(149, 109, 244, 1.0));
var KDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Color.fromRGBO(1, 90, 90, 90));

void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]s
  ).then((fn){*/
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: KDarkColorScheme,
          appBarTheme: AppBarTheme(
            backgroundColor: KDarkColorScheme.surfaceContainerLow,
            foregroundColor: KDarkColorScheme.onSecondaryContainer,
          ),
          cardTheme: CardTheme(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            color: KDarkColorScheme.secondaryContainer,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: KDarkColorScheme.primaryContainer,
          )),
          textTheme: TextTheme(
              titleLarge: TextStyle(
            color: KDarkColorScheme.surfaceContainerLow,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ))),
      theme: ThemeData(
          colorScheme: KColorScheme,
          appBarTheme: AppBarTheme(
              backgroundColor: KColorScheme.onPrimaryContainer,
              foregroundColor: KColorScheme.primaryContainer),
          cardTheme: CardTheme(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            color: KColorScheme.secondaryContainer,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: KColorScheme.primaryContainer,
          )),
          textTheme: TextTheme(
              titleLarge: TextStyle(
            color: KColorScheme.onSecondaryContainer,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ))),
      home: Expenses(),
    ),
  );
  // },
  //);
}
