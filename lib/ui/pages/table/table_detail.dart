import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/extensions/number_extension.dart';
import 'package:pos/state_manager/state_manager.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';
import 'package:pos/utils/order_item_utils.dart';

import 'dialog_quantity.dart';

class TableDetail extends StatelessWidget {
  final TableDetailCubit tableCubit;
  const TableDetail(this.tableCubit, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: tableCubit,
      child: POSScreen(tableCubit),
    );
  }
}

class POSScreen extends StatefulWidget {
  final TableDetailCubit tableCubit;
  const POSScreen(this.tableCubit, {Key? key}) : super(key: key);

  @override
  _POSScreenState createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  double _total = 30.00;
  double _discount = 4.00;
  int _selectedTable = 5;
  String _currentInput = '';
  TablePos? _table;
  int _chooseCategory = 0;

  @override
  void initState() {
    widget.tableCubit.loadData();
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _addNumberToInput(String number) {
    setState(() {
      _currentInput += number;
    });
  }

  void _clearInput() {
    setState(() {
      _currentInput = '';
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
            return _buildMenuItem(data.hiveId!.substring(0, 3), data.name!,
                data.price!, appColors(context).white, () {
              int quantity = 1;
              showDialog(
                  context: context,
                  builder: (_) {
                    return QuantityPopup(
                      onEmitQuantity: (value) {
                        quantity = value;
                      },
                    );
                  });
              OrderItem order = OrderItemUtils.createOrderTemp(
                  product: data, tableId: _table!.tableId!, quantity: quantity);
              widget.tableCubit.addOrderTemp(order: order);
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
              "${price.formatMoney()}",
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
              _buildFunctionButton(Icons.add, Colors.teal[600]!),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildNumpadButton("4"),
              _buildNumpadButton("5"),
              _buildNumpadButton("6"),
              _buildFunctionButton(Icons.remove, Colors.teal[600]!),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildNumpadButton("7"),
              _buildNumpadButton("8"),
              _buildNumpadButton("9"),
              _buildFunctionButton(Icons.close, Colors.teal[600]!),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              _buildNumpadButton("X"),
              _buildNumpadButton("0"),
              _buildNumpadButton("00"),
              _buildFunctionButton(Icons.search, Colors.teal[600]!),
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
                  onPressed: () {},
                  child: const Text(
                    "Đặt món",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const VerticalDivider(color: Colors.white, width: 1),
              Expanded(
                child: TextButton(
                  onPressed: () {},
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

  Widget _buildNumpadButton(String text) {
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
          onPressed: () => _addNumberToInput(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Widget _buildFunctionButton(IconData icon, Color color) {
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
          onPressed: () {},
          child: Icon(icon, size: 28),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _table = ModalRoute.of(context)!.settings.arguments as TablePos;
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
                    "Giảm % | C",
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "4,00",
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
                  Text(
                    _total.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
                                final item = state.orderTemp[index];
                                final bool isEven = index % 2 == 0;
                                return Container(
                                  color:
                                      isEven ? Colors.white : Colors.grey[200],
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      children: [
                                        Text(item.hiveId!.substring(0, 3)),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          flex: 2,
                                          child: Text(item.product!.name!),
                                        ),
                                        SizedBox(
                                          width: 30,
                                          child: Text(
                                            "${item.quantity}",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Text(
                                            item.product!.price.formatMoney(),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: Text(
                                            (item.totalAmount).formatMoney(),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
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
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: "Nhập mã món ăn",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
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
                Expanded(
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
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 0.5,
                                    ),
                                  ),
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
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 0.5,
                                  ),
                                ),
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
                                      fillter: AppConstants.THUC_AN);
                                  setState(() {
                                    _chooseCategory = 0;
                                  });
                                },
                                decoration: BoxDecoration(
                                    color: _chooseCategory == 0
                                        ? appColors(context).primaryColor
                                        : appColors(context).primaryColor75),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.dining, color: Colors.white),
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
                                  widget.tableCubit
                                      .fillterData(fillter: AppConstants.NUOC);
                                  setState(() {
                                    _chooseCategory = 1;
                                  });
                                },
                                decoration: BoxDecoration(
                                    color: _chooseCategory == 1
                                        ? appColors(context).primaryColor
                                        : appColors(context).primaryColor75),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
}
