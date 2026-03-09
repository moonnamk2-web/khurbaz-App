import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static bool isLightMode() {
    if (AppThemes.themeMode == ThemeMode.light) {
      return true;
    } else {
      return false;
    }
  }

  static ThemeMode themeMode = ThemeMode.light;
  static ThemeData light = ThemeData(
    fontFamily: 'DINNextLT',
    useMaterial3: true,
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: kPrimaryWhiteColor,
      rangePickerBackgroundColor: kPrimaryWhiteColor,
      surfaceTintColor: kPrimaryWhiteColor,
      backgroundColor: kPrimaryWhiteColor,
      dayStyle: TextStyle(fontFamily: 'DINNextLT', color: kMainColor),
      headerHeadlineStyle: TextStyle(
        fontFamily: 'DINNextLT',
        color: Colors.black,
      ),
      headerHelpStyle: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      weekdayStyle: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      // dayBackgroundColor: WidgetStateProperty.all(kMainColor),
      // da: WidgetStateProperty.all(kMainColor.withOpacity(0.2)),
      yearForegroundColor: WidgetStateProperty.all(kMainColor.withOpacity(0.7)),
    ),

    /// main colors
    primaryColor: kMainColor,
    colorScheme: ColorScheme.fromSeed(
      primary: kMainColor,
      seedColor: kMainColor,
      onSecondary: kPrimaryWhiteColor,
      background: kContainerBackground,
      primaryContainer: kContainerBackground,
      secondary: kScaffoldWhiteBackground,
      outline: Colors.black,
      // secondaryContainer: kPrimaryWhiteColor,
      // onPrimaryContainer: kPrimaryWhiteColor,
      // onSecondaryContainer: kPrimaryWhiteColor,
      surface: kPrimaryWhiteColor,
      surfaceContainer: kPrimaryWhiteColor,
      surfaceContainerHigh: kPrimaryWhiteColor,
      surfaceContainerHighest: kPrimaryWhiteColor,
      surfaceContainerLow: kPrimaryWhiteColor,
      surfaceContainerLowest: kPrimaryWhiteColor,
      // onSurface: kPrimaryWhiteColor,
    ),
    scaffoldBackgroundColor: kScaffoldBackground,
    iconTheme: const IconThemeData(color: Colors.black),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        backgroundColor: WidgetStateProperty.all(kPrimaryWhiteColor),
      ),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: kPrimaryWhiteColor),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: kPrimaryWhiteColor,
      selectedLabelStyle: TextStyle(
        fontFamily: 'DINNextLT',
        color: kMainColor,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.50,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: 'DINNextLT',
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.50,
      ),
    ),

    /// appBar theme
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      iconTheme: const IconThemeData(color: Colors.black),
    ),

    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(color: kMainColor, width: 1.5),
      checkColor: MaterialStateProperty.all(kPrimaryWhiteColor),
    ),

    dividerColor: kBorderOverlayColor,
    dividerTheme: const DividerThemeData(color: kBorderOverlayColor),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        textStyle: WidgetStateProperty.all(
          TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
        ),
      ),
    ),

    /// Text Style
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      headlineMedium: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      headlineSmall: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      displayLarge: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      displayMedium: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      displaySmall: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      titleLarge: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      titleMedium: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      titleSmall: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      bodyLarge: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      bodyMedium: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      bodySmall: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      labelLarge: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      labelMedium: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
      labelSmall: TextStyle(fontFamily: 'DINNextLT', color: Colors.black),
    ),

    inputDecorationTheme: InputDecorationTheme(
      fillColor: kFieldBackgroundColor,
      filled: true,
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(width: 1, color: Colors.black),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(width: 1, color: Colors.black),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(width: 1, color: Colors.black),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(width: 0, color: Colors.transparent),
      ),
      prefixIconColor: CupertinoColors.black,
      suffixIconColor: CupertinoColors.black,
      labelStyle: TextStyle(
        fontFamily: 'DINNextLT',
        color: const Color(0xFF8E8E8E),
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
  static ThemeData dark = ThemeData(
    fontFamily: 'DINNextLT',
    useMaterial3: true,

    /// main colors
    primaryColor: kMainColor,
    colorScheme: const ColorScheme(
      primary: kDarkMaterialBackground,
      background: kDarkMaterialBackground,
      onBackground: kDarkMaterialBackground,
      primaryContainer: kDarkMaterialBackground,
      secondaryContainer: kDarkMaterialBackground,
      onPrimaryContainer: kDarkMaterialBackground,
      onSecondaryContainer: kDarkMaterialBackground,
      surface: kDarkMaterialBackground,
      surfaceContainer: kDarkMaterialBackground,
      surfaceContainerHigh: kDarkMaterialBackground,
      surfaceContainerHighest: kDarkMaterialBackground,
      surfaceContainerLow: kDarkMaterialBackground,
      surfaceContainerLowest: kDarkMaterialBackground,
      onSurface: kDarkMaterialBackground,
      brightness: Brightness.light,
      onPrimary: kDarkMaterialBackground,
      onSecondary: kDarkContainerBackground,
      error: kDarkMaterialBackground,
      onError: kDarkMaterialBackground,
      secondary: kDarkMaterialBackground,
      outline: kMainColor,
    ),
    scaffoldBackgroundColor: kDarkScaffoldBackground,
    iconTheme: const IconThemeData(color: kPrimaryWhiteColor),

    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: kDarkBottomSheetBackground,
    ),
    listTileTheme: ListTileThemeData(
      textColor: kPrimaryWhiteColor,
      titleTextStyle: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(kPrimaryWhiteColor),
        foregroundColor: WidgetStateProperty.all(kPrimaryWhiteColor),
        textStyle: WidgetStateProperty.all(
          TextStyle(fontFamily: 'DINNextLT', color: kPrimaryWhiteColor),
        ),
      ),
    ),

    drawerTheme: const DrawerThemeData(
      backgroundColor: kDarkBottomNavigationBarBackground,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kDarkBottomNavigationBarBackground,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        backgroundColor: WidgetStateProperty.all(kPrimaryTitleColor),
      ),
    ),

    /// appBar theme
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      toolbarTextStyle: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      iconTheme: const IconThemeData(color: kPrimaryWhiteColor),
    ),

    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(color: kMainColor, width: 1.5),
      checkColor: MaterialStateProperty.all(kPrimaryWhiteColor),
    ),

    dividerColor: kBorderOverlayColor,
    dividerTheme: const DividerThemeData(color: kBorderOverlayColor),

    /// Text Style
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      displayLarge: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      displayMedium: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      displaySmall: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      titleLarge: TextStyle(fontFamily: 'DINNextLT', color: kPrimaryWhiteColor),
      titleMedium: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      titleSmall: TextStyle(fontFamily: 'DINNextLT', color: kPrimaryWhiteColor),
      bodyLarge: TextStyle(fontFamily: 'DINNextLT', color: kPrimaryWhiteColor),
      bodyMedium: TextStyle(fontFamily: 'DINNextLT', color: kPrimaryWhiteColor),
      bodySmall: TextStyle(fontFamily: 'DINNextLT', color: kPrimaryWhiteColor),
      labelLarge: TextStyle(fontFamily: 'DINNextLT', color: kPrimaryWhiteColor),
      labelMedium: TextStyle(
        fontFamily: 'DINNextLT',
        color: kPrimaryWhiteColor,
      ),
      labelSmall: TextStyle(fontFamily: 'DINNextLT', color: kPrimaryWhiteColor),
    ),

    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: <TargetPlatform, PageTransitionsBuilder>{
    //     TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    //   },
    // ),

    /// input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      fillColor: kMainColor.withOpacity(0.1),
      filled: true,
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(width: 1, color: kMainColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(width: 1.5, color: kMainColor),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(width: 1.5, color: kMainColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(width: 1.5, color: kMainColor),
      ),
      prefixIconColor: kPrimaryWhiteColor,
      suffixIconColor: kPrimaryWhiteColor,
      hintStyle: TextStyle(
        fontFamily: 'DINNextLT',
        fontSize: 16,
        color: kPrimaryWhiteColor,
      ),
      labelStyle: TextStyle(
        fontFamily: 'DINNextLT',
        fontSize: 16,
        color: kPrimaryWhiteColor,
      ),
    ),
  );
}
