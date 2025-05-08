import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/table.dart';
import 'package:pos/extensions/number_extension.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/home_cubit/home.dart';
import 'package:pos/state_manager/table_detail/table_detail_cubit.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/pages/page.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';

class HomeBody extends StatefulWidget {
  final HomeCubit homeCubit;
  final TableDetailCubit tableCubit;
  const HomeBody(this.homeCubit, this.tableCubit, {super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int _index = 0;
  @override
  void initState() {
    widget.homeCubit.fetchData();

    super.initState();
  }

  // Table statuses

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tab header
        Container(
          color: const Color(0xFF22555D),
          child: Row(
            children: [
              Expanded(
                child: CustomMaterialButton(
                  alignment: Alignment.center,
                  onTap: () {
                    setState(() {
                      _index = 0;
                    });
                    widget.homeCubit.fillterTable(AppConstants.TABLE_ALL);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _index == 0
                        ? appColors(context).primaryColor75
                        : appColors(context).primaryColor50,
                  ),
                  child: Center(
                    child: BlocBuilder<HomeCubit, HomeState>(
                      buildWhen: (previous, current) =>
                          previous.tables.length != current.tables.length,
                      builder: (context, state) {
                        return 'Tất cả bàn (${state.tables.length})'.w500(
                            fontSize: 20,
                            color: _index == 0
                                ? appColors(context).white
                                : appColors(context).primaryColor);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomMaterialButton(
                  alignment: Alignment.center,
                  onTap: () {
                    setState(() {
                      _index = 1;
                    });
                    widget.homeCubit.fillterTable(AppConstants.TABLE_EMPTY);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _index == 1
                        ? appColors(context).primaryColor75
                        : appColors(context).primaryColor50,
                  ),
                  child: 'Bàn trống'.w500(
                      fontSize: 20,
                      color: _index == 1
                          ? appColors(context).white
                          : appColors(context).primaryColor),
                ),
              ),
              Expanded(
                child: CustomMaterialButton(
                  alignment: Alignment.center,
                  onTap: () {
                    setState(() {
                      _index = 2;
                    });
                    widget.homeCubit.fillterTable(AppConstants.TABLE_USING);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: _index == 2
                        ? appColors(context).primaryColor75
                        : appColors(context).primaryColor50,
                  ),
                  child: 'Có khách'.w500(
                      fontSize: 20,
                      color: _index == 2
                          ? appColors(context).white
                          : appColors(context).primaryColor),
                ),
              ),
            ],
          ),
        ),

        // Tables grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                if (state.status == LoadStatus.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                  itemCount: widget.homeCubit.tables.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10),
                  itemBuilder: (context, index) {
                    final data = widget.homeCubit.tables[index];
                    return buildTable(data, () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  TableDetail(widget.tableCubit, data)));
                    });
                  },
                );
              },
            ),
          ),
        ),

        // Bottom navigation
        Container(
          color: const Color(0xFF22555D),
          child: Row(
            children: [
              buildNavButton("Trong nhà", () {
                widget.homeCubit.changePosition(AppConstants.TRONG_NHA);
              }),
              buildNavButton("Ngoài nhà", () {
                widget.homeCubit.changePosition(AppConstants.NGOAI_NHA);
              }),
              // const Spacer(),
              // buildNavButton('Số dự bàn', icon: Icons.assignment),
              // buildNavButton('Thanh toán', icon: Icons.payment),
              // buildNavButton('Đặt/giữ bàn', icon: Icons.event_seat),
              // buildNavButton('Hóa đơn', icon: Icons.receipt),
              // buildNavButton('Bàn phím', icon: Icons.keyboard),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTable(TablePos table, VoidCallback onTap) {
    Color tableColor;
    Color textColor = Colors.black;

    switch (table.status) {
      case AppConstants.TABLE_USING:
        tableColor = appColors(context).primaryColor;
        textColor = appColors(context).white;
        break;
      case AppConstants.TABLE_EMPTY:
        tableColor = appColors(context).white;
        textColor = appColors(context).primaryColor;
        break;

      default:
        tableColor = Colors.white;
    }

    return CustomMaterialButton(
      onTap: () {
        onTap.call();
      },
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: tableColor,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 3,
              left: 3,
              child: "${table.amount.formatMoney()}"
                  .w400(fontSize: 16, color: textColor)),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  table.code.toString(),
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 3,
              left: 50,
              child: "${table.userName}"
                  .w400(fontSize: 20, color: appColors(context).white))
        ],
      ),
    );
  }

  Widget buildNavButton(String title, VoidCallback callBack, {IconData? icon}) {
    return CustomMaterialButton(
      onTap: () {
        callBack.call();
      },
      padding: EdgeInsets.symmetric(
          horizontal: icon != null ? 12 : 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
        ),
      ),
      child: icon != null
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white, size: 20),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            )
          : Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
    );
  }
}

enum TableStatus {
  empty,
  occupied,
  available,
}
