import 'package:flutter/material.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/extensions/date_time_extension.dart';
import 'package:pos/extensions/number_extension.dart';
import 'package:pos/extensions/string_extension.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/state_manager.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';
import 'package:pos/utils/order_utils.dart';

class PaymentScreen extends StatefulWidget {
  final double total;
  final TableDetailCubit tableDetailCubit;
  final TablePos table;
  final int? position;
  const PaymentScreen(this.tableDetailCubit, this.table,
      {Key? key, required this.total, this.position})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double totalAmount = 10.00;
  double customerPayment = 20.00;
  double change = 10.00;
  double voucherAmount = 0.00;
  int checkNumber = 0;
  double sumTip = 0.00;
  double tipAmount = 0.00;

  final TextEditingController _tongMoney = TextEditingController();
  final TextEditingController _thoiMoney = TextEditingController();
  final TextEditingController _khachduaMoney = TextEditingController();
  double _price = 0;
  String choosePrice = '';
  @override
  void initState() {
    super.initState();
    _handleRouteArguments();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    init();
  }

  void init() async {
    // _tongMoney.text = _price.formatMoney();
    _khachduaMoney.addListener(() {
      double value = ((_khachduaMoney.text.toAmount() ?? 0) -
          (_tongMoney.text.toAmount() ?? 0));
      _thoiMoney.text = (value < 0 ? 0.0 : value).formatMoney();
    });
  }

  void _handleRouteArguments() async {
    await widget.tableDetailCubit
        .loadData(
      table: widget.table,
      fillter: widget.tableDetailCubit.state.fillter,
      position: widget.position,
    )
        .then((value) {
      setState(() {
        _tongMoney.text = value.formatMoney();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Summary section
          _buildSummarySection(),

          // Cash buttons
          _buildCashButtonsSection(),

          // Bottom action buttons
          _buildBottomActionButtons(),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(
            color: Color(0xFF2D545E),
          ),
          children: [
            _buildTableHeaderCell('Tổng tiền', Colors.white),
            _buildTableHeaderCell('Khách đưa', Colors.white),
            _buildTableHeaderCell('Tiền thối', Colors.white),
          ],
        ),
        TableRow(
          children: [
            _buildTableValueCell('$totalAmount', Colors.teal[900], _tongMoney),
            _buildTableValueCell(
                '$customerPayment', Colors.black, _khachduaMoney),
            _buildTableValueCell('$change', Colors.teal[900], _thoiMoney),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentDetailsSection() {
    return Table(
      border: TableBorder.all(color: Colors.blue[200]!),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(
            color: Color(0xFF2D545E),
          ),
          children: [
            _buildTableHeaderCell('Gutchein', Colors.white),
            _buildTableHeaderCell('Check', Colors.white),
            _buildTableHeaderCell('SUM TIP', Colors.white),
            _buildTableHeaderCell('TIP', Colors.white),
          ],
        ),
        TableRow(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('$voucherAmount', style: const TextStyle(fontSize: 18)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text('$checkNumber', style: const TextStyle(fontSize: 18)),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text('$sumTip', style: const TextStyle(fontSize: 18)),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              alignment: Alignment.centerLeft,
              child: Text('$tipAmount', style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCashButtonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 16),
          child: Text(
            'Tiền mặt',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
        ),
        Row(
          children: [
            _buildCashButton(
              '5,00',
              choosePrice == '5,00'
                  ? appColors(context).primaryColor25
                  : Colors.grey[300]!,
              callBack: () {
                _khachduaMoney.text = '5';
                setState(() {
                  choosePrice = '5,00';
                });
              },
            ),
            _buildCashButton(
                '10,00',
                choosePrice == '10,00'
                    ? appColors(context).primaryColor25
                    : Colors.grey[300]!, callBack: () {
              _khachduaMoney.text = '10';
              setState(() {
                choosePrice = '10,00';
              });
            }),
            _buildCashButton(
                '20,00',
                choosePrice == '20,00'
                    ? appColors(context).primaryColor25
                    : Colors.grey[300]!, callBack: () {
              _khachduaMoney.text = '20';
              setState(() {
                choosePrice = '20,00';
              });
            }),
          ],
        ),
        Row(
          children: [
            _buildCashButton(
                '50,00',
                choosePrice == '50,00'
                    ? appColors(context).primaryColor25
                    : Colors.grey[300]!, callBack: () {
              _khachduaMoney.text = '50';
              setState(() {
                choosePrice = '50,00';
              });
            }),
            _buildCashButton(
                '100,00',
                choosePrice == '100,00'
                    ? appColors(context).primaryColor25
                    : Colors.grey[300]!, callBack: () {
              _khachduaMoney.text = '100';
              setState(() {
                choosePrice = '100,00';
              });
            }),
            _buildCashButton(
                '200,00',
                choosePrice == '200,00'
                    ? appColors(context).primaryColor25
                    : Colors.grey[300]!, callBack: () {
              _khachduaMoney.text = '200';
              setState(() {
                choosePrice = '200,00';
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildCustomerSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Khách hàng',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text('Tìm/ chọn khách'),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF003E46),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionButtons() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  color: Color(0xFF003E46),
                ),
                children: [
                  CustomMaterialButton(
                    onTap: () async {
                      Order order = OrderUtils.createOrder(
                          orderTemp: widget.tableDetailCubit.items,
                          pay: AppConstants.TIEN_MAT,
                          username: widget.tableDetailCubit.user?.username);
                      await widget.tableDetailCubit
                          .paymeny(order: order)
                          .then((value) {
                        widget.tableDetailCubit
                            .deleteOrderTemp(tableId: widget.table.tableId!);

                        Navigator.pushNamed(context, AppRoutes.home);
                      });
                    },
                    height: 80,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.account_balance_wallet, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Tiền mặt',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomMaterialButton(
                    onTap: () async {
                      Order order = OrderUtils.createOrder(
                          orderTemp: widget.tableDetailCubit.items,
                          pay: AppConstants.TRATHE,
                          username: widget.tableDetailCubit.user?.username);
                      // await widget.tableDetailCubit
                      //     .paymeny(order: order)
                      //     .then((value) {
                      //   widget.tableDetailCubit
                      //       .deleteOrderTemp(tableId: widget.table.tableId!);

                      //   Navigator.pushNamed(context, AppRoutes.home);
                      // });
                      showDialog(
                          context: context,
                          builder: (_) => BillPayment(
                                order: order,
                              ));
                    },
                    height: 80,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.credit_card, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Trả thẻ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeaderCell(String text, Color textColor) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildTableValueCell(
      String text, Color? textColor, TextEditingController controller) {
    return Container(
        height: 50,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: TextField(
          controller: controller,
        ));
  }

  Widget _buildCashButton(String text, Color bgColor,
      {VoidCallback? callBack}) {
    return Expanded(
      child: CustomMaterialButton(
        onTap: () {},
        height: 50,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: TextButton(
          onPressed: () {
            callBack?.call();
            print(1);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: bgColor == const Color(0xFF003E46)
                  ? Colors.white
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class BillPayment extends StatefulWidget {
  final Order order;
  const BillPayment({required this.order, super.key});

  @override
  State<BillPayment> createState() => _BillPaymentState();
}

class _BillPaymentState extends State<BillPayment> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 400,
        padding: EdgeInsets.symmetric(horizontal: 5),
        color: appColors(context).white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 5,
          children: [
            _header(context),
            SizedBox(
              height: 5,
            ),
            _border(),
            _bodyHeader(),
            _doubleBorder(),
            Column(
              spacing: 5,
              children: [
                Column(
                    children: widget.order.items!
                        .map((e) => Column(
                              children: [
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        _listOrder(context, data: e),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                          height: 1,
                                        ),
                                    itemCount: widget.order.items?.length ?? 0)
                              ],
                            ))
                        .toList())
              ],
            ),
            _total(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget _header(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 2,
      children: [
        "TNKAS".w500(fontSize: 18, color: appColors(context).black),
        "Magdeburg".w300(fontSize: 15, color: appColors(context).black),
        "10367 Berlin".w300(fontSize: 15, color: appColors(context).black),
        "Steuer Nr:. Ma so thue"
            .w300(fontSize: 15, color: appColors(context).black),
        "Telefonnr: 032269974522"
            .w300(fontSize: 15, color: appColors(context).black),
      ],
    );
  }

  Widget _bodyHeader() {
    return Column(
      spacing: 5,
      children: [
        "R.Nr: M6-0012".w300(fontSize: 20),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "${widget.order.username}".w400(fontSize: 15),
            "Bestellung Uhrzeit  ${DateTime.now().format()}".w400(fontSize: 15),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "Tisch: ${widget.order.items?.first.tableId}".w400(fontSize: 15),
            "Datum ${DateTime.now().format(format: Constants.commonDateFormat)}"
                .w400(fontSize: 15),
          ],
        ),
      ],
    );
  }

  Widget _border() {
    return Text("=========");
  }

  Widget _doubleBorder() {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        _border(),
        SizedBox(
          height: 2,
        ),
        _border(),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  Widget _listOrder(context, {OrderItem? data}) {
    // List<LocalDbItemExtra> extras = [];
    // List<LocalDbNote> notes = [];
    // List<dynamic> jsonStringExtras =
    //     (data?.itemsExtra != null && data?.itemsExtra != "")
    //         ? jsonDecode(data!.itemsExtra!)
    //         : [];
    // List<dynamic> jsonStringNotes =
    //     (data?.itemsNote != null && data?.itemsNote != "")
    //         ? jsonDecode(data!.itemsNote!)
    //         : [];
    // jsonStringExtras.forEach((e) {
    //   extras.add(LocalDbItemExtra.parse(e));
    // });
    // jsonStringNotes.forEach((e) {
    //   notes.add(LocalDbNote.fromJson(e));
    // });
    return Column(
      spacing: 10,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                "${data?.quantity}x".w300(fontSize: 18),
                SizedBox(
                  width: 5,
                ),
                "${data?.product?.name}".w300(fontSize: 18),
              ],
            ),
            Row(
              children: [
                "${data?.product?.price}".w400(fontSize: 18),
                SizedBox(
                  width: 5,
                ),
                "${data?.totalAmount}".w400(fontSize: 18),
              ],
            )
          ],
        ),
        for (int i = 0;
            i < (data?.extras?.length != 0 ? data!.extras!.length : 0);
            i++)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  "+${data?.extras?[i].quantity}x".w400(fontSize: 12),
                  SizedBox(
                    width: 5,
                  ),
                  "${data?.extras?[i].name}".w300(fontSize: 12),
                ],
              ),
              Row(
                children: [
                  "${data?.extras?[i].price}".w300(fontSize: 12),
                  SizedBox(
                    width: 15,
                  ),
                  "${data?.extras?[i].total}".w300(fontSize: 12),
                ],
              )
            ],
          ),
      ],
    );
  }

  Widget _total() {
    return Column(
      spacing: 5,
      children: [
        _border(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            "".w300(fontSize: 15),
            "19% MwST:  0.19".w300(fontSize: 15),
          ],
        )
      ],
    );
  }

  Widget _batch({required String name}) {
    int _width = (MediaQuery.of(context).size.width / 2).toInt();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < _width / 2; i += 7)
          "*".w700(
            fontSize: 20,
          ),
        name.w400(fontSize: 30),
        for (var i = _width / 2; i < _width; i += 7) "*".w700(fontSize: 20),
      ],
    );
  }

  Widget _area({required String name}) {
    int _width = (MediaQuery.of(context).size.width / 2).toInt();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < _width / 2; i += 9)
          "*".w700(
            fontSize: 15,
          ),
        name.w400(fontSize: 20),
        for (var i = _width / 2; i < _width; i += 9) "*".w700(fontSize: 15),
      ],
    );
  }
}
