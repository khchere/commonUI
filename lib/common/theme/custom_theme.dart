import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/app_colors.dart';
import 'color/abs_theme_colors.dart';
import 'color/dark_app_colors.dart';
import 'color/light_app_colors.dart';
import 'shadows/abs_theme_shadows.dart';
import 'shadows/dart_app_shadows.dart';
import 'shadows/light_app_shadows.dart';
import 'package:google_fonts/google_fonts.dart';

enum CustomTheme {
  dark(
    DarkAppColors(),
    DarkAppShadows(),
  ),
  light(
    LightAppColors(),
    LightAppShadows(),
  );

  const CustomTheme(this.appColors, this.appShadows);

  final AbstractThemeColors appColors;
  final AbsThemeShadows appShadows;

  ThemeData get themeData {
    switch (this) {
      case CustomTheme.dark:
        return darkTheme;
      case CustomTheme.light:
        return lightTheme;
    }
  }
}

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.notoSansKr(
          fontSize: 59,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5
      ),
      displayMedium: GoogleFonts.notoSansKr(
          fontSize: 47,
          fontWeight: FontWeight.w400
      ),
      displaySmall: GoogleFonts.notoSansKr(
          fontSize: 33,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25
      ),
      headlineMedium: GoogleFonts.notoSansKr(
          fontSize: 33,
          fontWeight: FontWeight.w400
      ),
      headlineSmall: GoogleFonts.notoSansKr(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15
      ),
      titleLarge: GoogleFonts.notoSansKr(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15
      ),
      titleMedium: GoogleFonts.notoSansKr(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1
      ),
      bodySmall: GoogleFonts.notoSansKr(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4
      ),
      bodyLarge: GoogleFonts.roboto(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5
      ),
      bodyMedium: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blue,
      textTheme: ButtonTextTheme.primary,
    ),
    primaryColor: AppColors.blue,
    primaryColorLight: Colors.yellow,
    dividerTheme: const DividerThemeData(
      color: AppColors.brightGrey,
      thickness: 1,
      space: 0,
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.saPrimary,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.saPrimary,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      backgroundColor: AppColors.saPrimary,
      titleTextStyle: GoogleFonts.notoSansKr(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    ),

    // textTheme: CustomGoogleFonts.diphylleiaTextTheme(
    //   ThemeData(brightness: Brightness.light).textTheme,
    // ),
    // colorScheme:
    //     ColorScheme.fromSeed(seedColor: CustomTheme.light.appColors.seedColor));
);

const darkColorSeed = Color(0xbcd5ff7e);
ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.veryDarkGrey,
    // textTheme: GoogleFonts.nanumMyeongjoTextTheme(
    //   ThemeData(brightness: Brightness.dark).textTheme,
    // ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: CustomTheme.dark.appColors.seedColor,
        brightness: Brightness.dark));
