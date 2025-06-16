import 'package:flutter/material.dart';

ThemeData lightTheme=ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.green,
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white
    ),
    cardTheme: CardThemeData(
        color: Colors.white
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.green),
            foregroundColor: WidgetStateProperty.all(Colors.white)
        )
    ),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            foregroundColor: WidgetStateProperty.all(Colors.green)
        )
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.green
        ),

      ),
      labelStyle: TextStyle(
          color: Colors.black
      ),


    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
   progressIndicatorTheme: ProgressIndicatorThemeData(
     color: Colors.green
   )
);