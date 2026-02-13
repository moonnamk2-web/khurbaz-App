import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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


    // material 3
    useMaterial3: true,
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: kPrimaryWhiteColor,
      rangePickerBackgroundColor: kPrimaryWhiteColor,
      surfaceTintColor: kPrimaryWhiteColor,
      backgroundColor: kPrimaryWhiteColor,
      dayStyle: GoogleFonts.cairo(color: kMainColor),
      headerHeadlineStyle: GoogleFonts.cairo(color: Colors.black),
      headerHelpStyle: GoogleFonts.cairo(color: Colors.black),
      weekdayStyle: GoogleFonts.cairo(color: Colors.black),
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
      selectedLabelStyle: GoogleFonts.cairo(
        color: kMainColor,
        fontSize: 12,
        fontWeight: FontWeight.w700,
        height: 1.50,
      ),
      unselectedLabelStyle: GoogleFonts.cairo(
        color: Colors.black,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.50,
      ),
    ),

    /// appBar theme
    appBarTheme: AppBarTheme(
      titleTextStyle: GoogleFonts.cairo(color: Colors.black),
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
          GoogleFonts.cairo(color: Colors.black),
        ),
      ),
    ),

    /// Text Style
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.cairo(color: Colors.black,),
      headlineMedium: GoogleFonts.cairo(color: Colors.black,),
      headlineSmall: GoogleFonts.cairo(color: Colors.black,),
      displayLarge: GoogleFonts.cairo(color: Colors.black,),
      displayMedium: GoogleFonts.cairo(color: Colors.black,),
      displaySmall: GoogleFonts.cairo(color: Colors.black,),
      titleLarge: GoogleFonts.cairo(color: Colors.black,),
      titleMedium: GoogleFonts.cairo(color: Colors.black,),
      titleSmall: GoogleFonts.cairo(color: Colors.black,),
      bodyLarge: GoogleFonts.cairo(color: Colors.black,),
      bodyMedium: GoogleFonts.cairo(color: Colors.black,),
      bodySmall: GoogleFonts.cairo(color: Colors.black,),
      labelLarge: GoogleFonts.cairo(color: Colors.black,),
      labelMedium: GoogleFonts.cairo(color: Colors.black,),
      labelSmall: GoogleFonts.cairo(color: Colors.black,),
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
      labelStyle: GoogleFonts.cairo(
        color: const Color(0xFF8E8E8E),
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
  static ThemeData dark = ThemeData(
    // material 3
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
    listTileTheme:  ListTileThemeData(
      textColor: kPrimaryWhiteColor,
      titleTextStyle: GoogleFonts.cairo(color: kPrimaryWhiteColor),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all(kPrimaryWhiteColor),
        foregroundColor: WidgetStateProperty.all(kPrimaryWhiteColor),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.cairo(color: kPrimaryWhiteColor),
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
      titleTextStyle: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      toolbarTextStyle: GoogleFonts.cairo(color: kPrimaryWhiteColor),
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
      headlineLarge: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      headlineMedium: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      headlineSmall: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      displayLarge: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      displayMedium: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      displaySmall: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      titleLarge: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      titleMedium: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      titleSmall: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      bodyLarge: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      bodyMedium: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      bodySmall: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      labelLarge: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      labelMedium: GoogleFonts.cairo(color: kPrimaryWhiteColor),
      labelSmall: GoogleFonts.cairo(color: kPrimaryWhiteColor),
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
      hintStyle: GoogleFonts.cairo(fontSize: 16, color: kPrimaryWhiteColor),
      labelStyle: GoogleFonts.cairo(fontSize: 16, color: kPrimaryWhiteColor),
    ),
  );
}
