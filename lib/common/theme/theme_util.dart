import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeUtil {
  static Brightness get systemBrightness =>
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  // static void changeTheme(BuildContext context, CustomTheme theme) {
  //   CustomThemeApp.saveThemeFunction(theme);
  //   context.changeTheme(theme);
  // }
  //
  // static void toggleTheme(BuildContext context) {
  //   final theme = context.themeType;
  //   switch (theme) {
  //     case CustomTheme.dark:
  //       changeTheme(context, CustomTheme.light);
  //       break;
  //     case CustomTheme.light:
  //       changeTheme(context, CustomTheme.dark);
  //       break;
  //   }
  // }
}
