

// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// class CustomTimePicker extends CommonPickerModel {
//   String digits(int index, int pad) {
//     return '$index'.padLeft(pad, '0');
//   }

//   CustomTimePicker({int time, LocaleType locale}) : super(locale: locale) {
//     this.setLeftIndex(time);
//     this.setMiddleIndex(time);
//     this.setRightIndex(time);
//   }

//   @override
//   String leftStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }

//   @override
//   String rightStringAtIndex(int index) {
//     if (index >= 0 && index < 60) {
//       return this.digits(index, 2);
//     } else {
//       return null;
//     }
//   }

//   @override
//   String leftDivider() {
//     return '|';
//   }

//   @override
//   String rightDivider() {
//     return '|';
//   }

//   // @override
//   // List<int> layoutProportions() {
//   //   return [1, 2, 2];
//   // }
// }
