import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/extensions/number_extension.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/state_manager.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';
import 'package:pos/utils/order_item_utils.dart';

import 'payment.dart';

class TableDetail extends StatelessWidget {
  final TableDetailCubit tableCubit;
  final TablePos table;
  const TableDetail(this.tableCubit, this.table, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: tableCubit,
      child: POSScreen(tableCubit, table),
    );
  }
}

class POSScreen extends StatefulWidget {
  final TableDetailCubit tableCubit;
  final TablePos table;

  const POSScreen(this.tableCubit, this.table, {Key? key}) : super(key: key);

  @override
  _POSScreenState createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  TextEditingController _currentInput = TextEditingController();
  TablePos? _table;
  bool ispay = false;
  int _chooseCategory = 0;
  int _position = 0;
  double _price = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _handleRouteArguments();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _addNumberToInput(String number) {
    setState(() {
      _currentInput.text += number;
    });
  }

  void _handleRouteArguments() async {
    setState(() {
      _table = widget.table;
    });

    await widget.tableCubit
        .loadData(
      table: _table!,
      fillter: widget.tableCubit.state.fillter,
      position: _position,
    )
        .then((value) {
      setState(() {
        _price = value;
      });
    });
  }

  Widget _buildMenuGrid() {
    return BlocBuilder<TableDetailCubit, TableDetailState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == LoadStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 3, crossAxisSpacing: 3),
          itemBuilder: (context, index) {
            final data = state.product[index];

            return _buildMenuItem(
                data.code!, data.name!, data.price!, appColors(context).white,
                () {
              if (data.extras?.length != 0) {
                showDialog(
                  useRootNavigator: false,
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    List<Extra> _extra = [];
                    return StatefulBuilder(builder: (context, statefulBuilder) {
                      return Dialog(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(0)),
                        child: Container(
                          width: 300,
                          height: 300,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: data.extras?.length,
                                        itemBuilder: (context, index) {
                                          var extra = data.extras![index];
                                          extra.quantity = 1;
                                          extra.total = extra.price;

                                          return CustomMaterialButton(
                                              onTap: () {
                                                statefulBuilder(() {
                                                  _extra.add(extra);
                                                });
                                              },
                                              alignment: Alignment.center,
                                              height: 60,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: _extra.contains(extra)
                                                      ? appColors(context)
                                                          .primaryColor
                                                      : appColors(context)
                                                          .white,
                                                ),
                                                color: _extra.contains(extra)
                                                    ? appColors(context)
                                                        .primaryColor
                                                    : appColors(context).white,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  extra.name!.w400(
                                                      fontSize: 20,
                                                      color: _extra
                                                              .contains(extra)
                                                          ? appColors(context)
                                                              .white
                                                          : appColors(context)
                                                              .primaryColor),
                                                  extra.price
                                                      .formatMoney()
                                                      .w400(
                                                          fontSize: 20,
                                                          color: _extra
                                                                  .contains(
                                                                      extra)
                                                              ? appColors(
                                                                      context)
                                                                  .white
                                                              : appColors(
                                                                      context)
                                                                  .primaryColor)
                                                ],
                                              ));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomMaterialButton(
                                  onTap: () {
                                    Navigator.pop(context);
                                    OrderItem order =
                                        OrderItemUtils.createOrderTemp(
                                            product: data,
                                            tableId: _table!.tableId!,
                                            quantity: 1,
                                            extras: _extra,
                                            username: widget
                                                .tableCubit.user?.username,
                                            position: _position);
                                    widget.tableCubit.addOrderTemp(
                                        order: order,
                                        position: _position,
                                        tableId: _table!.tableId!);
                                  },
                                  height: 70,
                                  width: 120,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: appColors(context).primaryColor),
                                  child: "Order".w400(
                                      fontSize: 20,
                                      color: appColors(context).white))
                            ],
                          ),
                        ),
                      );
                    });
                  },
                );
              } else {
                OrderItem order = OrderItemUtils.createOrderTemp(
                    product: data,
                    tableId: _table!.tableId!,
                    quantity: 1,
                    username: widget.tableCubit.user?.username,
                    position: _position);
                widget.tableCubit.addOrderTemp(
                    order: order,
                    position: _position,
                    tableId: _table!.tableId!);
              }
            }, "gg");
          },
          itemCount: state.product.length,
        );
      },
    );
  }

  Widget _buildMenuItem(
      String id, String name, double price, Color bgColor, VoidCallback onTap,
      [String? imagePath]) {
    return CustomMaterialButton(
      onTap: () {
        onTap.call();
      },
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            width: double.infinity,
            child: Text(
              id,
              style: const TextStyle(fontSize: 35),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                      imagePath!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.shopping_cart, size: 50);
                      },
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(4),
            color: Colors.white.withOpacity(0.7),
            child: Text(
              price.formatMoney(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumpad() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              _buildNumpadButton("1"),
              _buildNumpadButton("2"),
              _buildNumpadButton("3"),
              _buildFunctionButton(Icons.add, Colors.teal[600]!, onTap: () {
                if (widget.tableCubit.selectOrder != null) {
                  widget.tableCubit.selectOrder?.quantity =
                      widget.tableCubit.selectOrder!.quantity! + 1;
                  widget.tableCubit.selectOrder?.totalAmount =
                      widget.tableCubit.selectOrder!.quantity! *
                          widget.tableCubit.selectOrder!.product!.price!;
                  widget.tableCubit.updateOrder(
                      order: widget.tableCubit.selectOrder!,
                      position: _position);
                }
              }),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildNumpadButton("4"),
              _buildNumpadButton("5"),
              _buildNumpadButton("6"),
              _buildFunctionButton(Icons.remove, Colors.teal[600]!, onTap: () {
                if (widget.tableCubit.selectOrder != null) {
                  widget.tableCubit.selectOrder?.quantity =
                      widget.tableCubit.selectOrder!.quantity! - 1;
                  widget.tableCubit.selectOrder?.totalAmount =
                      widget.tableCubit.selectOrder!.quantity! *
                          widget.tableCubit.selectOrder!.product!.price!;
                  widget.tableCubit.updateOrder(
                      order: widget.tableCubit.selectOrder!,
                      position: _position);
                }
              }),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildNumpadButton("7"),
              _buildNumpadButton("8"),
              _buildNumpadButton("9"),
              _buildFunctionButton(Icons.close, Colors.teal[600]!, onTap: () {
                if (widget.tableCubit.selectOrder != null) {
                  widget.tableCubit.deleteOrder(
                      order: widget.tableCubit.selectOrder!,
                      position: _position);
                }
              }),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildNumpadButton("X", onTap: () {
                setState(() {
                  _currentInput.text = '';
                });
              }),
              _buildNumpadButton("0"),
              _buildNumpadButton("00"),
              _buildFunctionButton(Icons.search, Colors.teal[600]!, onTap: () {
                widget.tableCubit.findProduct(search: _currentInput.text);
              }),
            ],
          ),
        ),
        Container(
          color: const Color(0xFF2D545E),
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Enter",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const VerticalDivider(color: Colors.white, width: 1),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    widget.tableCubit.order().then((value) {
                      if (value) {
                        Navigator.pushReplacementNamed(context, AppRoutes.home);
                      }
                    });
                  },
                  child: const Text(
                    "Đặt món",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const VerticalDivider(color: Colors.white, width: 1),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      ispay = !ispay;
                    });
                  },
                  child: const Text(
                    "Thanh toán",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumpadButton(String text, {VoidCallback? onTap}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(1),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: () {
            _addNumberToInput(text);
            onTap?.call();
          },
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildFunctionButton(IconData icon, Color color,
      {VoidCallback? onTap}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(1),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: () {
            onTap?.call();
          },
          child: Icon(icon, size: 28),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _getTotal();

    // widget.tableCubit.loadData(table: _table!);

    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            color: const Color(0xFF2D545E),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    "${widget.tableCubit.user?.username}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    _table!.tableId!,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Tổng",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder<TableDetailCubit, TableDetailState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return Text(
                        _price.formatMoney(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Main content
          Expanded(
            child: Row(
              children: [
                // Left side - Order items
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // Order Items
                      Expanded(
                        child: BlocBuilder<TableDetailCubit, TableDetailState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return ListView.builder(
                              itemCount: state.orderTemp.length,
                              itemBuilder: (context, index) {
                                var item = state.orderTemp[index];
                                Color _color =
                                    widget.tableCubit.selectOrder?.hiveId ==
                                            item.hiveId
                                        ? appColors(context).primaryColor
                                        : appColors(context).white;
                                Color _colorText =
                                    widget.tableCubit.selectOrder?.hiveId ==
                                            item.hiveId
                                        ? appColors(context).white
                                        : appColors(context).primaryColor;
                                return ConstrainedBox(
                                  constraints: BoxConstraints(minHeight: 50),
                                  child: CustomMaterialButton(
                                    onTap: () {
                                      widget.tableCubit
                                          .selectOrders(order: item);
                                      setState(() {});
                                    },
                                    decoration: BoxDecoration(
                                      color: _color,
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                item.hiveId!.substring(0, 3),
                                                style: TextStyle(
                                                    color: _colorText),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  item.product!.name!,
                                                  style: TextStyle(
                                                      color: _colorText),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 30,
                                                child: Text(
                                                  "${item.quantity}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: _colorText),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 60,
                                                child: Text(
                                                  item.product!.price
                                                      .formatMoney(),
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: _colorText),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 60,
                                                child: Text(
                                                  (item.totalAmount)
                                                      .formatMoney(),
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      color: _colorText),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ListView.separated(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              final extra = item.extras?[index];
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  spacing: 10,
                                                  children: [
                                                    "+".w400(
                                                        fontSize: 15,
                                                        color: _colorText),
                                                    Expanded(
                                                      child: extra!.name!.w400(
                                                          fontSize: 10,
                                                          color: _colorText),
                                                    ),
                                                    SizedBox(
                                                      width: 40,
                                                      child: extra.quantity
                                                          .toString()
                                                          .w400(
                                                              fontSize: 10,
                                                              color:
                                                                  _colorText),
                                                    ),
                                                    SizedBox(
                                                      width: 40,
                                                      child: extra.price
                                                          .formatMoney()
                                                          .w400(
                                                              fontSize: 10,
                                                              color:
                                                                  _colorText),
                                                    ),
                                                    SizedBox(
                                                      width: 40,
                                                      child: extra.total
                                                          .formatMoney()
                                                          .w400(
                                                              fontSize: 10,
                                                              color:
                                                                  _colorText),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (context, index) => SizedBox(),
                                            itemCount: item.extras?.length ?? 0)
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),

                      // Input Field
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _currentInput,
                                decoration: const InputDecoration(
                                  hintText: "Nhập mã món ăn",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            CustomMaterialButton(
                              onTap: () {
                                if (_currentInput.text.isNotEmpty) {
                                  setState(() {
                                    _currentInput.text = _currentInput.text
                                        .substring(
                                            0, _currentInput.text.length - 1);
                                  });
                                }
                              },
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2D545E),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Numpad
                      SizedBox(
                        height: 250,
                        child: _buildNumpad(),
                      ),
                    ],
                  ),
                ),

                // Right side - Menu items
                ispay
                    ? Expanded(
                        flex: 7,
                        child: BlocBuilder<TableDetailCubit, TableDetailState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return PaymentScreen(
                              total: _price,
                              widget.tableCubit,
                              _table!,
                              position: _position,
                            );
                          },
                        ))
                    : Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            // Tab Buttons
                            Container(
                              color: const Color(0xFF2D545E),
                              child: Row(
                                children: [
                                  for (int i = 1; i <= _table!.seats!; i++)
                                    Expanded(
                                      child: CustomMaterialButton(
                                        onTap: () {
                                          setState(() {
                                            _position = i;
                                          });
                                          widget.tableCubit.loadPosition(
                                              position: _position);
                                        },
                                        height: 40,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 0.5,
                                            ),
                                            color: _position == i
                                                ? appColors(context)
                                                    .primaryColor
                                                : appColors(context)
                                                    .primaryColor75),
                                        child: Center(
                                          child: Text(
                                            "$i",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  Expanded(
                                    child: CustomMaterialButton(
                                      onTap: () {
                                        setState(() {
                                          _position = 0;
                                        });
                                        widget.tableCubit
                                            .loadPosition(position: _position);
                                      },
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 0.5,
                                          ),
                                          color: _position == 0
                                              ? appColors(context).primaryColor
                                              : appColors(context)
                                                  .primaryColor75),
                                      child: Center(
                                        child: Text(
                                          "Tất cả",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Category Tabs
                            Container(
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomMaterialButton(
                                      onTap: () {
                                        widget.tableCubit.fillterData(
                                            fillter: AppConstants.THUC_AN,
                                            position: _position);
                                        setState(() {
                                          _chooseCategory = 0;
                                        });
                                      },
                                      decoration: BoxDecoration(
                                          color: _chooseCategory == 0
                                              ? appColors(context).primaryColor
                                              : appColors(context)
                                                  .primaryColor75),
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.dining,
                                              color: Colors.white),
                                          Text(
                                            "Thức ăn",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomMaterialButton(
                                      onTap: () {
                                        widget.tableCubit.fillterData(
                                            fillter: AppConstants.NUOC,
                                            position: _position);
                                        setState(() {
                                          _chooseCategory = 1;
                                        });
                                      },
                                      decoration: BoxDecoration(
                                          color: _chooseCategory == 1
                                              ? appColors(context).primaryColor
                                              : appColors(context)
                                                  .primaryColor75),
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.local_drink,
                                              color: Colors.white),
                                          Text(
                                            "Nước",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Menu Grid
                            Expanded(
                              child: Row(
                                children: [
                                  // Menu Items Grid
                                  Expanded(flex: 4, child: _buildMenuGrid()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getTotal() {
    double _price = 0;
    widget.tableCubit.items.forEach((e) {
      _price += e.totalAmount!;
      e.extras?.forEach((ele) {
        _price += ele.total!;
      });
    });
    return _price;
  }
}
