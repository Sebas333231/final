import "package:flutter/material.dart";

// este manager es de ayudara en los condicionales ternarios a identificar si la vista esta en modo claro o modo oscuro

class ThemeManager with ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark){
    _themeMode = isDark?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }
}