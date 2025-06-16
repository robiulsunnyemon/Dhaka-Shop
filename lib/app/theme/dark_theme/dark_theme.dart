import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark, // ডার্ক থিমের জন্য এটি অবশ্যই সেট করুন
  scaffoldBackgroundColor: Colors.grey[900], // ডার্ক ব্যাকগ্রাউন্ড
  primaryColor: Colors.greenAccent[400], // ডার্ক মোডে একটু উজ্জ্বল গ্রিন
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850], // ডার্ক অ্যাপবার
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  cardTheme: CardThemeData(
    color: Colors.grey[800], // ডার্ক কার্ড
    elevation: 2,
    margin: EdgeInsets.all(8),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.greenAccent[400]),
      foregroundColor: MaterialStateProperty.all(Colors.black), // টেক্সট কালার
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
      foregroundColor: MaterialStateProperty.all(
        Colors.greenAccent[400],
      ), // গ্রিন টেক্সট
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[800],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.greenAccent[400]!),
    ),
    labelStyle: TextStyle(color: Colors.grey[300]), // লাইট গ্রে টেক্সট
    hintStyle: TextStyle(color: Colors.grey[500]),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.grey[900], // ডার্ক ব্যাকগ্রাউন্ড
    selectedItemColor: Colors.greenAccent[400],
    unselectedItemColor: Colors.grey[500],
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.greenAccent[400], // ডার্ক মোডে উজ্জ্বল ইন্ডিকেটর
    circularTrackColor: Colors.grey[700],
  ),
  // ডার্ক মোডের জন্য অতিরিক্ত কমন সেটিংস
  dividerColor: Colors.grey[700],
  iconTheme: IconThemeData(color: Colors.grey[300]),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.grey[300]), // প্রধান টেক্সট কালার
    bodyMedium: TextStyle(color: Colors.grey[300]),
  ),
);
