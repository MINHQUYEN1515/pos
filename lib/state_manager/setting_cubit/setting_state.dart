import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/local_model.dart';

class SettingState extends Equatable {
  final LoadStatus status;
  final List<TablePos> table;
  final List<Product> product;
  final List<UserLocal> users;

  const SettingState(
      {this.status = LoadStatus.initial,
      this.product = const [],
      this.table = const [],
      this.users = const []});
  @override
  List<Object?> get props => [status, product, table, table];

  SettingState copyWith(
      {LoadStatus? status,
      List<TablePos>? table,
      List<Product>? product,
      List<UserLocal>? users}) {
    return SettingState(
        status: status ?? this.status,
        table: table ?? this.table,
        product: product ?? this.product,
        users: users ?? this.users);
  }
}
