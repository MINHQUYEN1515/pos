import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/extensions/date_time_extension.dart';
import 'package:pos/extensions/number_extension.dart';
import 'package:pos/state_manager/invoice_cubit/invoice.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';

import 'invoice_detai.dart';

class InvoiceListScreen extends StatelessWidget {
  final InvoiceCubit cubit;

  const InvoiceListScreen(this.cubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: InvoiceListScreenChild(cubit),
    );
  }
}

class InvoiceListScreenChild extends StatefulWidget {
  final InvoiceCubit cubit;
  const InvoiceListScreenChild(this.cubit, {Key? key}) : super(key: key);

  @override
  State<InvoiceListScreenChild> createState() => _InvoiceListScreenChildState();
}

class _InvoiceListScreenChildState extends State<InvoiceListScreenChild> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  String invoiceType = 'Tất cả hóa đơn';
  String staff = 'Tất cả nhân viên';
  String pos = 'Tất cả thiết bị';
  final Map<String, String> parseTypeBill = {
    'Tất cả hóa đơn': AppConstants.ALl,
    'Tiền mặt': AppConstants.TIEN_MAT,
    'Trả thẻ': AppConstants.TRATHE
  };
  bool _isShowDetail = false;
  List<OrderItem>? _orderItem;
  @override
  void initState() {
    widget.cubit.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF33565E),
        title: Row(
          children: [
            const Icon(Icons.receipt_long, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              'Danh sách hóa đơn',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [],
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                _buildFilterSection(),
                _buildInvoiceTable(),
              ],
            ),
          ),
          if (_isShowDetail)
            Expanded(
                flex: 2,
                child: ReceiptScreen(
                  order: _orderItem!,
                ))
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Từ ngày',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildDatePicker(startDate, (date) {
                      widget.cubit.fillterData(startDay: date, endDay: endDate);
                      setState(() {
                        startDate = date;
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Đến ngày',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildDatePicker(endDate, (date) {
                      widget.cubit
                          .fillterData(startDay: startDate, endDay: date);

                      setState(() {
                        endDate = date;
                      });
                    }),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Loại hóa đơn',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildDropdown(
                      invoiceType,
                      ['Tất cả hóa đơn', 'Tiền mặt', 'Trả thẻ'],
                      (value) {
                        setState(() {
                          invoiceType = value!;
                        });
                        widget.cubit.fillterData(
                            startDay: startDate,
                            endDay: endDate,
                            typeBill: parseTypeBill[invoiceType]);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nhân viên',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    BlocBuilder<InvoiceCubit, InvoiceState>(
                      buildWhen: (previous, current) =>
                          previous.status != current.status ||
                          previous.users.length != current.users.length,
                      builder: (context, state) {
                        return _buildDropdown(
                          staff,
                          state.users,
                          (value) {
                            widget.cubit.fillterData(
                                startDay: startDate,
                                endDay: endDate,
                                typeBill: parseTypeBill[invoiceType],
                                username: value);
                            setState(() {
                              staff = value!;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(DateTime initialDate, Function(DateTime) onChanged) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: new DateTime(2020),
            lastDate: new DateTime(2030) //Cannot be 2020
            );
        if (picked != null) {
          onChanged(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('dd.MM.yyyy').format(initialDate),
              style: const TextStyle(fontSize: 14),
            ),
            const Icon(Icons.calendar_today, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
      String value, List<String> items, Function(String?) onChanged) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildInvoiceTable() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildTableHeader(),
            BlocBuilder<InvoiceCubit, InvoiceState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status ||
                  previous.invoices.length != current.invoices.length,
              builder: (context, state) {
                return Expanded(
                  child: ListView.separated(
                    itemCount: state.invoices.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return _buildInvoiceRow(state.invoices[index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF33565E),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: Row(
        children: [
          _headerCell('Mã hóa đơn', flex: 1),
          _headerCell('Thời gian', flex: 2),
          _headerCell('Nhân viên / Tài xế', flex: 2),
          _headerCell('Tổng cộng', flex: 1),
          _headerCell('Phương thức thanh toán', flex: 2),
          _headerCell('Số bàn', flex: 1),
        ],
      ),
    );
  }

  Widget _headerCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInvoiceRow(Order invoice) {
    return CustomMaterialButton(
      onTap: () {
        setState(() {
          _isShowDetail = true;
          _orderItem = invoice.items;
        });
      },
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          _dataCell(invoice.hiveId!.substring(0, 3), flex: 1),
          _dataCell(
            DateTime.parse(invoice.createdAt!)
                .format(format: Constants.dayMonthYearFormat),
            // DateFormat('dd.MM.yyyy HH:mm:ss').format(),
            flex: 2,
          ),
          _dataCell(invoice.username!, flex: 2),
          _dataCell(invoice.amount.formatMoney(), flex: 1),
          _dataCell(
              invoice.payment == AppConstants.TIEN_MAT ? "Tiền mặt" : "Trả thẻ",
              flex: 2),
          _dataCell(
              "${invoice.items?.length != 0 ? invoice.items?.first.tableId : ''}",
              flex: 1),
        ],
      ),
    );
  }

  Widget _dataCell(String text, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class Invoice {
  final String id;
  final DateTime dateTime;
  final String staff;
  final double total;
  final String paymentMethod;
  final String posNumber;

  Invoice({
    required this.id,
    required this.dateTime,
    required this.staff,
    required this.total,
    required this.paymentMethod,
    required this.posNumber,
  });
}
