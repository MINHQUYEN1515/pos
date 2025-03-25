import 'enum.dart';

class LocalConstants {
  ///Table ID
  static const int ID_TABLE_PRODUCT = 1;
  static const int ID_TABLE_TABLE = 2;
  static const int ID_TABLE_ORDER_ITEM = 3;
  static const int ID_TABLE_ORDER = 4;
  static const int ID_TABLE_BILL = 5;
  static const int ID_TABLE_CATEGORY = 6;
  //Table name
  static const String TABLE_PRODUCT = "TABLE_PRODUCT";
  static const String TABLE_TABLE = "TABLE_TABLE";
  static const String TABLE_ORDER_ITEM = "TABLE_ORDER_ITEM";
  static const String TABLE_ORDER = "TABLE_ORDER";
  static const String TABLE_BILL = "TABLE_BILL";
  static const String TABLE_CATEGORY = "TABLE_CATEGORY";
}

class AppConstants {
  static const String KEY = "ASDFGHJKLASDFGHJ";
  static const Map<int, Screen> screenMap = {
    0: Screen.setting,
    1: Screen.restaurent,
  };
  static const String TABLE_USING = "using";
  static const String TABLE_EMPTY = 'empty';
  static const String TABLE_ALL = 'all';
}

class Constants {
  // TODO: will update later
  static const int taxPercent = 0;
  static const int startIdOfLocalRecord = 100000;
  static const String commonDateFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String commonHourFormat = 'HH:mm';
  static const String commonFullHourFormat = 'HH:mm:ss';
  static const String dayMonthYearFormat = 'dd-MM-yyyy';
  static const String yearFirstFormat = 'YYYY-MM-dd';
}
