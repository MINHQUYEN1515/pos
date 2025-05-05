import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/table.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/state_manager.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/app_drop_button.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/ui/widgets/textfield/app_text_field_label.dart';
import 'package:pos/utils/logger.dart';

class ConfigTable extends StatefulWidget {
  final SettingCubit settingCubit;
  const ConfigTable(this.settingCubit, {super.key});

  @override
  State<ConfigTable> createState() => _ConfigTableState();
}

class _ConfigTableState extends State<ConfigTable> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _seats = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _position = TextEditingController();
  final Map<String, String> valueMap = {
    "Trong nhà": AppConstants.TRONG_NHA,
    "Ngoài nhà": AppConstants.NGOAI_NHA
  };
  String _value = "Trong nhà";
  @override
  void initState() {
    _position.text = "trongnha";
    widget.settingCubit.loadTable();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _seats.dispose();
    _code.dispose();
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.status == LoadStatus.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            spacing: 20,
            children: [
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: AppTextFieldLabel(
                      lable: "Tên bàn",
                      borderRadius: 0,
                      hintText: "Tên bàn",
                      hintStyle: TextStyle(color: appColors(context).grey25),
                      controller: _name,
                    ),
                  ),
                  Expanded(
                    child: AppTextFieldLabel(
                      lable: "Số ghế",
                      borderRadius: 0,
                      hintText: "Số ghế",
                      hintStyle: TextStyle(color: appColors(context).grey25),
                      controller: _seats,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: AppTextFieldLabel(
                      lable: "Mã bàn",
                      borderRadius: 0,
                      hintText: "Mã bàn",
                      hintStyle: TextStyle(color: appColors(context).grey25),
                      controller: _code,
                    ),
                  ),
                  Expanded(
                    child: AppDropButton(
                      height: 60,
                      items: ["Trong nhà", "Ngoài nhà"],
                      lable: "Vị trí",
                      borderRadius: 0,
                      value: _value,
                      onChange: (value) {
                        _position.text = valueMap[value]!;

                        logger.i(_position.text);
                      },
                      // hintText: "Vị trí",
                      // hintStyle:
                      //     TextStyle(color: appColors(context).grey25),
                      // controller: _position,
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: "DANH SÁCH BÀN".w500(fontSize: 40),
                  ),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(child: "Mã bàn".w600(fontSize: 30)),
                        Expanded(child: "Số ghế".w600(fontSize: 30)),
                        Expanded(child: "Vị trí".w600(fontSize: 30)),
                        SizedBox(
                          width: 150,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BlocBuilder<SettingCubit, SettingState>(
                          buildWhen: (previous, current) =>
                              previous.status != current.status,
                          builder: (context, state) {
                            return ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final data = state.table[index];
                                  return _buildTable(
                                      table: data,
                                      onDelete: () {
                                        widget.settingCubit
                                            .deleteTable(hiveId: data.hiveId!);
                                      },
                                      onEdit: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) => Dialog(
                                                  child: _buildEditTable(
                                                      table: data),
                                                ));
                                      });
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(),
                                itemCount: state.table.length);
                          },
                        )
                      ],
                    ),
                  ))
                ],
              )),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomMaterialButton(
                    onTap: () {
                      try {
                        int seat = int.parse(_seats.text);
                        widget.settingCubit.craeteTable(
                            tableName: _name.text,
                            code: _code.text,
                            seats: seat,
                            position: _position.text);
                      } catch (e) {
                        AppDialogCustomer.showConfirmDialog(
                            "Vui lòng nhập đúng định dạng so ghe");
                      }
                    },
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                        color: appColors(context).primaryColor75,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(10))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save,
                          size: 30,
                          color: appColors(context).white,
                        ),
                        "Lưu".w400(
                            fontSize: 20, color: appColors(context).white),
                      ],
                    )),
              )
            ],
          ),
        );
      },
    );
  }

  _buildTable(
      {required TablePos table, VoidCallback? onEdit, VoidCallback? onDelete}) {
    return Container(
      height: 50,
      child: Row(
        children: [
          Expanded(child: "${table.code}".w400(fontSize: 30)),
          Expanded(child: "${table.seats}".w400(fontSize: 30)),
          Expanded(
              child: (table.position == AppConstants.NGOAI_NHA
                      ? "Ngoài nhà"
                      : "Trong nhà")
                  .w400(fontSize: 30)),
          SizedBox(
            width: 150,
            child: Row(
              spacing: 10,
              children: [
                IconButton(
                    onPressed: () {
                      onEdit?.call();
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () {
                      onDelete?.call();
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildEditTable({required TablePos table}) {
    TextEditingController _name = TextEditingController();
    TextEditingController _seats = TextEditingController();
    TextEditingController _code = TextEditingController();
    TextEditingController _type = TextEditingController();
    final Map<String, String> valueMap = {
      "Trong nhà": AppConstants.TRONG_NHA,
      "Ngoài nhà": AppConstants.NGOAI_NHA
    };
    final Map<String, String> valueMapParse = {
      AppConstants.TRONG_NHA: "Trong nhà",
      AppConstants.NGOAI_NHA: "Ngoài nhà"
    };
    String _value = "Trong nhà";
    _name.text = table.tableId ?? "";
    _seats.text = table.seats.toString();
    _code.text = table.code ?? "";
    _type.text = valueMapParse[table.position] ?? "";

    return Container(
      padding: EdgeInsets.all(20),
      width: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          AppTextFieldLabel(
            lable: "Tên bàn",
            controller: _name,
            onChanged: (value) {
              table.tableId = value;
            },
          ),
          AppTextFieldLabel(
            lable: "Số ghế",
            controller: _seats,
            onChanged: (value) {
              table.seats = int.parse(value);
            },
          ),
          AppTextFieldLabel(
            lable: "Mã bàn",
            controller: _code,
            onChanged: (value) {
              table.code = value;
            },
          ),
          AppDropButton(
            lable: "Vị trí",
            items: ["Trong nhà", "Ngoài nhà"],
            value: _value,
            onChange: (value) {
              _position.text = valueMap[value]!;
              table.position = _position.text;
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomMaterialButton(
                onTap: () {
                  widget.settingCubit.updateTable(table: table);
                  Navigator.pop(context);
                },
                height: 50,
                width: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: appColors(context).primaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child:
                    "Lưu".w400(fontSize: 25, color: appColors(context).white)),
          )
        ],
      ),
    );
  }
}
