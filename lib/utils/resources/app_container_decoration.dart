// import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

final mainDecoration = ShapeDecoration(
  color: kPrimaryWhiteColor,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  shadows: const [
    BoxShadow(
      color: Color(0x2D000000),
      blurRadius: 50,
      offset: Offset(0, 24),
      spreadRadius: -20,
    ),
    BoxShadow(
      color: Color(0x35FFFFFF),
      blurRadius: 0,
      offset: Offset(4, -4),
      spreadRadius: 0,
    ),
  ],
);
final sideDecoration = BoxDecoration(
  color: Colors.white,
  border: const Border(right: BorderSide(width: 4, color: Color(0xFF158A8A))),
  borderRadius: BorderRadius.circular(8),
  boxShadow: const [
    BoxShadow(color: Color(0x35FFFFFF), blurRadius: 0, offset: Offset(4, -4)),
    BoxShadow(color: Color(0x0C000000), blurRadius: 4, offset: Offset(0, 4)),
  ],
);
// final dateConfigRang = CalendarDatePicker2WithActionButtonsConfig(
//   selectedDayHighlightColor: kMainColor,
//   calendarType: CalendarDatePicker2Type.range,
//   selectedDayTextStyle: GoogleFonts.cairo(color: Colors.white),
//   dayTextStyle: GoogleFonts.cairo(color: Colors.black),
//   todayTextStyle: GoogleFonts.cairo(color: Colors.black),
//   monthTextStyle: GoogleFonts.cairo(color: Colors.black),
//   disabledMonthTextStyle: GoogleFonts.cairo(color: Colors.black),
//   yearTextStyle: GoogleFonts.cairo(color: Colors.black),
//   weekdayLabelTextStyle: GoogleFonts.cairo(color: kMainColor),
//   controlsTextStyle: GoogleFonts.cairo(color: kMainColor),
// );
// final dateConfig = CalendarDatePicker2WithActionButtonsConfig(
//   selectedDayHighlightColor: kMainColor,
//   calendarType: CalendarDatePicker2Type.single,
//   selectedDayTextStyle: GoogleFonts.cairo(color: Colors.white),
//   dayTextStyle: GoogleFonts.cairo(color: Colors.black),
//   todayTextStyle: GoogleFonts.cairo(color: Colors.black),
//   monthTextStyle: GoogleFonts.cairo(color: Colors.black),
//   disabledMonthTextStyle: GoogleFonts.cairo(color: Colors.black),
//   yearTextStyle: GoogleFonts.cairo(color: Colors.black),
//   weekdayLabelTextStyle: GoogleFonts.cairo(color: kMainColor),
//   controlsTextStyle: GoogleFonts.cairo(color: kMainColor),
// );
