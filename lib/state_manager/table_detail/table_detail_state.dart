import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/local_model.dart';

class TableDetailState extends Equatable {
  final LoadStatus status;
  final List<Product> product;
  final List<OrderItem> orderTemp;
  const TableDetailState(
      {this.status = LoadStatus.initial,
      this.product = const [],
      this.orderTemp = const []});
  @override
  List<Object?> get props => [status, product, orderTemp];
  TableDetailState copyWith(
      {LoadStatus? status,
      List<Product>? product,
      List<OrderItem>? orderTemp}) {
    return TableDetailState(
        status: status ?? this.status,
        product: product ?? this.product,
        orderTemp: orderTemp ?? this.orderTemp);
  }
}
