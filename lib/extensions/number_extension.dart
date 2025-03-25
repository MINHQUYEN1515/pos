import 'package:intl/intl.dart';

extension DoubleExt on double? {
  String formatMoney() {
    if (this == null) return '0,00';
    return this!.toStringAsFixed(2).replaceAll('.', ',');
  }

  double precision(int precision) =>
      double.tryParse((this ?? 0.0).toStringAsFixed(precision)) ?? 0.0;

  String formatDouble2fTSE() {
    final f = NumberFormat("%.2f", 'en');
    return f.format(this.precision(2)).replaceAll(",", ".");
  }
}
