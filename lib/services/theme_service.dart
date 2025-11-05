import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService {
  static const _key = 'isDarkMode';
  ThemeMode theme = ThemeMode.system;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key);
    if (isDark == null)
      theme = ThemeMode.system;
    else
      theme = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> switchTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, isDark);
    theme = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
