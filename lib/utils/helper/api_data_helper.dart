// import 'package:intl/intl.dart';
//
// class ApiDataHelper {
//   static int? getInt(i) {
//     switch (i) {
//       case String:
//         return double.tryParse(i)?.toInt();
//
//       case int:
//         return i;
//     }
//
//     return null;
//   }
//
//   static double? getDouble(i) {
//     switch (i) {
//       case String:
//         return double.tryParse(i);
//
//       case int:
//         return i.toDouble();
//
//       case double:
//         return i;
//     }
//
//     return null;
//   }
//
//   static num? getNum(i) {
//     switch (i) {
//       case String:
//         print('=======1');
//         return double.tryParse(i);
//
//       case num:
//         print('=======2');
//         return i;
//     }
//     print('=======3');
//
//     return null;
//   }
//
//   static bool? getBool(i) {
//     switch (i) {
//       case String:
//         return i == '1' || i == 'true';
//
//       case int:
//         return i == 1;
//
//       case bool:
//         return i;
//     }
//
//     return null;
//   }
//
//   static DateTime? getDateTimeFromStamp(i) {
//     final timeStamp = getInt(i);
//     return timeStamp != null
//         ? DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000)
//         : null;
//   }
//
//   static DateTime? getDateTimeFromFormattedStringYYYYMMDD(String? i) {
//     if (i == null) return null;
//     return DateFormat("yyyy-MM-dd").tryParse(i);
//   }
// }
