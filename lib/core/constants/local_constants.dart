import 'package:flutter/material.dart';

import 'enum.dart';

class LocalConstants {
  ///Table ID
  static const int ID_TABLE_PRODUCT = 1;
  static const int ID_TABLE_TABLE = 2;
  static const int ID_TABLE_ORDER_ITEM = 3;
  static const int ID_TABLE_ORDER = 4;
  static const int ID_TABLE_BILL = 5;
  static const int ID_TABLE_CATEGORY = 6;
  static const int ID_TABLE_EXTRA = 7;
  static const int ID_TABLE_USER = 8;
  static const int ID_TABLE_PERMISSION = 9;
  //Table name
  static const String TABLE_PRODUCT = "TABLE_PRODUCT";
  static const String TABLE_TABLE = "TABLE_TABLE";
  static const String TABLE_ORDER_ITEM = "TABLE_ORDER_ITEM";
  static const String TABLE_ORDER = "TABLE_ORDER";
  static const String TABLE_BILL = "TABLE_BILL";
  static const String TABLE_CATEGORY = "TABLE_CATEGORY";
  static const String TABLE_EXTRA = 'TABLE_EXTRA';
  static const String TABLE_USER = 'TABLE_USER';
  static const String TABLE_PERMISSON = 'TABLE_PERMISSON';
}

class AppConstants {
  static const String KEY = "ASDFGHJKLASDFGHJ";
  static const Map<int, Screen> screenMap = {
    1: Screen.setting,
    2: Screen.restaurent,
    3: Screen.restaurent,
    5: Screen.invoice
  };
  static const String TABLE_USING = "using";
  static const String TABLE_EMPTY = 'empty';
  static const String TABLE_ALL = 'all';
  static const String TRONG_NHA = 'trongnha';
  static const String NGOAI_NHA = 'ngoainha';
  static const String THUC_AN = 'thucan';
  static const String NUOC = 'nuoc';
  static const String TIEN_MAT = 'tienmat';
  static const String TRATHE = 'trathe';
  static const String ALl = 'all';
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
