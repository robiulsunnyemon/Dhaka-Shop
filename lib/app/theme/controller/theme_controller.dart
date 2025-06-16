import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find<ThemeController>();

  final RxBool _isDark = false.obs;

  // Expose the boolean value
  bool get isDark => _isDark.value;

  // Reactive theme mode variable
  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  // SharedPreferences key
  static const String _themePrefKey = 'theme_mode';

  // Getter for current theme mode
  ThemeMode get themeMode => _themeMode.value;

  // Your light theme configuration
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    primaryColor: Colors.green,
    primaryColorLight: Colors.black87,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 2,
      margin: EdgeInsets.all(8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.green),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
      labelStyle: TextStyle(color: Colors.black),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.green,
    ),
    dividerColor: Colors.grey[300],
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    dialogTheme: DialogThemeData(backgroundColor: Colors.white),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black87
      )
  );

  // Your dark theme configuration
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    cardColor: Colors.grey[800],
    primaryColorLight: Colors.white,
    primaryColor: Colors.grey,
    secondaryHeaderColor: Colors.black87,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    cardTheme: CardThemeData(
      color: Colors.grey[800],
      elevation: 2,
      margin: const EdgeInsets.all(8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.grey),
        foregroundColor: WidgetStateProperty.all(Colors.white),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        // backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.grey),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      labelStyle: TextStyle(color: Colors.grey[300]),
      hintStyle: TextStyle(color: Colors.grey[500]),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.greenAccent[400],
      unselectedItemColor: Colors.grey[500],
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.grey,
      //circularTrackColor: Colors.grey[700],
    ),
    dividerColor: Colors.grey[700],
    iconTheme: IconThemeData(color: Colors.grey[300]),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.grey[300]),
      bodyMedium: TextStyle(color: Colors.grey[300]),
    ),
    dialogTheme: DialogThemeData(backgroundColor: Colors.grey[800]),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.grey
    )
  );

  @override
  void onInit() {
    super.onInit();
    _loadThemeFromPrefs();
    ever(_themeMode, (ThemeMode mode) {
      _isDark.value =
          mode == ThemeMode.dark ||
          (mode == ThemeMode.system && Get.isPlatformDarkMode);
    });
  }

  // Load theme preference from SharedPreferences
  Future<void> _loadThemeFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themePrefKey) ?? 'system';
      _themeMode.value = _parseThemeMode(savedTheme);
      Get.changeThemeMode(_themeMode.value);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load theme preference');
    }
  }

  // Change theme and save preference
  Future<void> changeTheme(ThemeMode mode) async {
    try {
      _themeMode.value = mode;
      Get.changeThemeMode(mode);

      _isDark.value =
          mode == ThemeMode.dark ||
          (mode == ThemeMode.system && Get.isPlatformDarkMode);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_themePrefKey, mode.toString().split('.').last);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save theme preference');
    }
  }

  // Toggle between light and dark theme
  Future<void> toggleTheme() async {
    if (isDarkMode) {
      await changeTheme(ThemeMode.light);
    } else {
      await changeTheme(ThemeMode.dark);
    }
  }

  // Parse string to ThemeMode
  ThemeMode _parseThemeMode(String theme) {
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  // Helper getters
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;
  bool get isLightMode => _themeMode.value == ThemeMode.light;
  bool get isSystemMode => _themeMode.value == ThemeMode.system;

  // Get current theme data
  ThemeData get currentThemeData =>
      _themeMode.value == ThemeMode.dark ? darkTheme : lightTheme;
}
