import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/local_model.dart';

class HomeState extends Equatable {
  final LoadStatus status;
  final Screen screen;
  final List<TablePos> tables;
  const HomeState(
      {this.status = LoadStatus.initial,
      this.screen = Screen.restaurent,
      this.tables = const []});
  @override
  List<Object?> get props => [status, screen, tables];

  HomeState copyWith(
      {LoadStatus? status, Screen? screen, List<TablePos>? tables}) {
    return HomeState(
        status: status ?? this.status,
        screen: screen ?? this.screen,
        tables: tables ?? this.tables);
  }
}
