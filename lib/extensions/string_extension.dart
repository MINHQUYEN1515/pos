import 'package:intl/intl.dart';

extension StringExtension on String? {
  bool get isNullOrEmpty {
    if (this == null) return true;
    return this!.isEmpty;
  }

  bool get isNotNullOrEmpty {
    return this != null && this!.isNotEmpty;
  }

  bool get parseBool {
    return this?.toLowerCase() == 'true';
  }

  String capitalize() {
    if (this == null) return '';
    return "${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}";
  }

  String addChar(String ch, int position) {
    if (this.isNullOrEmpty || this!.length < position) return this ?? '';
    return this!.substring(0, position) + ch + this!.substring(position);
  }

  double? toAmount() {
    return double.tryParse((this ?? '').replaceAll(',', '.'));
  }

  DateTime parseInvoiceDate() {
    try {
      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(this ?? '');
      return DateTime.parse(parseDate.toString());
    } catch (e) {
      return DateTime.now();
    }
  }

  String formatCent() {
    final NumberFormat _currencyFormat =
        NumberFormat.currency(locale: 'de_DE', symbol: '');
    double parsedValue = double.parse(this ?? '0.00') / 100;

    // Format số tiền theo chuẩn Đức
    String formattedValue = _currencyFormat.format(parsedValue);
    return formattedValue;
  }
}
