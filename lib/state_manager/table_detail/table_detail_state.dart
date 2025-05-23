import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/local_model.dart';

class TableDetailState extends Equatable {
  final LoadStatus status;
  final List<Product> product;
  final List<OrderItem> orderTemp;
  final TablePos? table;
  final String? fillter;
  final OrderItem? selectOrders;
  final double price;
  final LoadStatus statusOrderTemp;
  const TableDetailState(
      {this.status = LoadStatus.initial,
      this.product = const [],
      this.orderTemp = const [],
      this.table,
      this.fillter,
      this.selectOrders,
      this.price = 0,
      this.statusOrderTemp = LoadStatus.initial});
  @override
  List<Object?> get props => [
        status,
        product,
        orderTemp,
        table,
        fillter,
        selectOrders,
        price,
        statusOrderTemp
      ];
  TableDetailState copyWith(
      {LoadStatus? status,
      List<Product>? product,
      List<OrderItem>? orderTemp,
      TablePos? table,
      String? fillter,
      OrderItem? selectOrders,
      double? price,
      LoadStatus? statusOrderTemp}) {
    return TableDetailState(
        status: status ?? this.status,
        product: product ?? this.product,
        orderTemp: orderTemp ?? this.orderTemp,
        table: table ?? this.table,
        fillter: fillter ?? this.fillter,
        selectOrders: selectOrders ?? this.selectOrders,
        price: price ?? this.price,
        statusOrderTemp: statusOrderTemp ?? this.statusOrderTemp);
  }
}
