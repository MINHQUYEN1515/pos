import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';

class HomeState extends Equatable {
  final LoadStatus status;
  final Screen screen;
  final List<TablePos> tables;
  final String type;

  final String position;
  const HomeState(
      {this.status = LoadStatus.initial,
      this.screen = Screen.restaurent,
      this.tables = const [],
      this.position = AppConstants.TRONG_NHA,
      this.type = AppConstants.TABLE_ALL});
  @override
  List<Object?> get props => [status, screen, tables, position, type];

  HomeState copyWith(
      {LoadStatus? status,
      Screen? screen,
      List<TablePos>? tables,
      String? position,
      String? type}) {
    return HomeState(
        status: status ?? this.status,
        screen: screen ?? this.screen,
        position: position ?? this.position,
        tables: tables ?? this.tables,
        type: type ?? this.type);
  }
}
