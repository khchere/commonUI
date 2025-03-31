import 'package:flutter/material.dart';

import 'custom_theme.dart';
import 'custom_theme_holder.dart';
import 'theme_util.dart';

class CustomThemeApp extends StatefulWidget {
  final Widget child;
  final CustomTheme? defaultTheme;
  final CustomTheme? savedTemme;

  // static late void Function(CustomTheme) saveThemeFunction;
  static late ValueChanged<CustomTheme> saveThemeFunction;

  static void init({required ValueChanged<CustomTheme> saveThemeFunction}) {
    CustomThemeApp.saveThemeFunction = saveThemeFunction;
  }

  const CustomThemeApp(
      {Key? key, required this.child, this.defaultTheme, this.savedTemme})
      : super(key: key);

  @override
  State<CustomThemeApp> createState() => _CustomThemeAppState();
}

class _CustomThemeAppState extends State<CustomThemeApp> {
  late CustomTheme theme =
      widget.savedTemme ?? widget.defaultTheme ?? systemTheme;

  void handleChangeTheme(CustomTheme theme) {
    setState(() => this.theme = theme);
  }

  @override
  Widget build(BuildContext context) {
    return CustomThemeHolder(
      changeTheme: handleChangeTheme,
      theme: theme,
      child: widget.child,
    );
  }

  // CustomTheme? get savedTheme => Prefs.appTheme.get();

  CustomTheme get systemTheme {
    switch (ThemeUtil.systemBrightness) {
      case Brightness.dark:
        return CustomTheme.dark;
      case Brightness.light:
        return CustomTheme.light;
    }
  }
}
