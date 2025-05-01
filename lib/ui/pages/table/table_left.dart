import 'package:flutter/material.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';

class TableLeft extends StatefulWidget {
  const TableLeft({super.key});

  @override
  State<TableLeft> createState() => _TableLeftState();
}

class _TableLeftState extends State<TableLeft> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _header(),
        Expanded(
            child: Column(
          children: [_orderItem()],
        ))
      ],
    );
  }

  Widget _header() {
    return Container(
      height: 90,
      color: appColors(context).primaryColor75,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "UserName".w500(fontSize: 20, color: appColors(context).white),
                "Ban 5".w500(fontSize: 20, color: appColors(context).white)
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Giam %".w500(fontSize: 20, color: appColors(context).white),
                "Ban 5".w500(fontSize: 20, color: appColors(context).white)
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Tong".w500(fontSize: 20, color: appColors(context).white),
                "Ban 5".w500(fontSize: 20, color: appColors(context).white)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _orderItem() {
    return CustomMaterialButton(
        padding: EdgeInsets.only(left: 5),
        height: 60,
        decoration: BoxDecoration(
            color: appColors(context).primaryColor25,
            border: Border.all(color: appColors(context).grey)),
        child: Row(
          children: [
            Expanded(
                child: Row(
              spacing: 10,
              children: [
                "1089"
                    .w400(fontSize: 12, color: appColors(context).primaryColor),
                "Ốc len xào dừa"
                    .w400(fontSize: 20, color: appColors(context).primaryColor)
              ],
            )),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                "1".w500(fontSize: 25),
                "3,30".w500(fontSize: 25),
                "3,30".w500(fontSize: 25)
              ],
            ))
          ],
        ));
  }
}
