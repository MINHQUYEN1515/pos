import 'package:equatable/equatable.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/local_model/local_model.dart';

class InvoiceState extends Equatable {
  final LoadStatus status;
  final List<Order> invoices;
  final List<String> users;
  const InvoiceState(
      {this.status = LoadStatus.initial,
      this.invoices = const [],
      this.users = const []});
  @override
  List<Object?> get props => [status, invoices, users];
  InvoiceState copyWith(
      {LoadStatus? status, List<Order>? invoices, List<String>? users}) {
    return InvoiceState(
        status: status ?? this.status,
        invoices: invoices ?? this.invoices,
        users: users ?? this.users);
  }
}
