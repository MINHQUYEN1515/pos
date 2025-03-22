import 'package:pos/core/constants/local_constants.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime? {
  bool isAfterNow() {
    if (this == null) return false;
    return this!.isAfter(DateTime.now());
  }

  String format({String format = Constants.commonDateFormat}) {
    if (this == null) return '';
    return DateFormat(format).format(this!);
  }
}
