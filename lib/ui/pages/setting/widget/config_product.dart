import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/extensions/number_extension.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/setting_cubit/setiing.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/app_drop_button.dart';
import 'package:pos/ui/widgets/dialog/app_dialog.dart';
import 'package:pos/ui/widgets/textfield/app_text_field_label.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/button/custom_material_button.dart';

class ConfigProduct extends StatefulWidget {
  final SettingCubit settingCubit;
  const ConfigProduct(this.settingCubit, {super.key});

  @override
  State<ConfigProduct> createState() => _ConfigProductState();
}

class _ConfigProductState extends State<ConfigProduct> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _type = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _codeExtra = TextEditingController();
  final TextEditingController _priceExtra = TextEditingController();

  String? _value;
  final Map<String, String> valueMap = {
    "Thức ăn": AppConstants.THUC_AN,
    "Nước": AppConstants.NUOC
  };
  bool _isActiveExtra = false;

  @override
  void initState() {
    _value = "Thức ăn";
    _type.text = AppConstants.THUC_AN;
    widget.settingCubit.loadProduct();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _price.dispose();
    _type.dispose();
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Expanded(
                  child: AppTextFieldLabel(
                lable: "Tên sản phẩm",
                hintText: "Tên sản phẩm",
                hintStyle: TextStyle(color: appColors(context).grey25),
                borderRadius: 0,
                controller: _name,
              )),
              Expanded(
                  child: AppTextFieldLabel(
                hintText: "Giá",
                lable: "Giá",
                hintStyle: TextStyle(color: appColors(context).grey25),
                borderRadius: 0,
                controller: _price,
              )),
            ],
          ),
          Row(
            spacing: 10,
            children: [
              Expanded(
                  child: AppDropButton(
                borderRadius: 0,
                height: 60,
                lable: "Loại món ăn",
                items: ["Thức ăn", "Nước"],
                value: _value,
                onChange: (value) {
                  _type.text = valueMap[value]!;
                },
              )),
              Expanded(
                  child: AppTextFieldLabel(
                lable: "Món mã",
                borderRadius: 0,
                controller: _code,
              ))
            ],
          ),
          Row(
            children: [
              Switch(
                  value: _isActiveExtra,
                  onChanged: (value) {
                    setState(() {
                      _isActiveExtra = value;
                    });
                  }),
              "Extra".w500(fontSize: 40, color: appColors(context).primaryColor)
            ],
          ),
          Visibility(
            visible: _isActiveExtra,
            child: Row(
              spacing: 10,
              children: [
                Expanded(
                    child: AppTextFieldLabel(
                  borderRadius: 0,
                  height: 60,
                  lable: "Tên Extras",
                  controller: _codeExtra,
                )),
                Expanded(
                    child: AppTextFieldLabel(
                  lable: "Giá",
                  borderRadius: 0,
                  controller: _priceExtra,
                ))
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                "DANH SÁCH MÓN"
                    .w500(fontSize: 50, color: appColors(context).primaryColor),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          spacing: 30,
                          children: [
                            Expanded(child: "ID".w400(fontSize: 30)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: "Tên".w600(
                                  fontSize: 30,
                                  color: appColors(context).primaryColor),
                            ),
                            Expanded(
                              child: "Thể loại".w400(fontSize: 30),
                            ),
                            Expanded(child: "Giá".w400(fontSize: 30)),
                          ],
                        ),
                      ),
                      SizedBox(width: 150, child: SizedBox())
                    ],
                  ),
                ),
                BlocBuilder<SettingCubit, SettingState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = state.product[index];
                          return ProductWidget(data: data, widget.settingCubit);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 1,
                            ),
                        itemCount: state.product.length);
                  },
                )
              ],
            ),
          )),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomMaterialButton(
                onTap: () async {
                  try {
                    double price = double.parse(_price.text);
                    double priceExtra = 0;
                    if (_priceExtra.text != null && _priceExtra.text != '') {
                      priceExtra = double.parse(_priceExtra.text);
                    }
                    await widget.settingCubit
                        .createProduct(
                            name: _name.text,
                            code: _code.text,
                            price: price,
                            type: _type.text,
                            codeExtra: _codeExtra.text,
                            priceExtra: priceExtra)
                        .then((value) {
                      if (value) {
                        _name.text = '';
                        _code.text = '';
                        price = 0;
                        _codeExtra.text = '';
                        _priceExtra.text = '';
                      }
                    });
                  } catch (e) {
                    AppDialogCustomer.showConfirmDialog(
                        "Vui lòng nhập đúng định dạng ");
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
                    "Lưu".w400(fontSize: 20, color: appColors(context).white),
                  ],
                )),
          )
        ],
      ),
    );
  }
}

class ProductWidget extends StatefulWidget {
  final Product data;
  final SettingCubit settingCubit;
  const ProductWidget(this.settingCubit, {required this.data, super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isShowExtra = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: appColors(context).grey),
            color: appColors(context).white),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: CustomMaterialButton(
                  onTap: () {
                    setState(() {
                      isShowExtra = !isShowExtra;
                    });
                  },
                  height: 60,
                  child: Row(
                    spacing: 30,
                    children: [
                      Expanded(
                          child: widget.data.hiveId!
                              .substring(0, 3)
                              .w400(fontSize: 30)),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 3,
                        child: widget.data.name!.w600(
                            fontSize: 30,
                            color: appColors(context).primaryColor),
                      ),
                      Expanded(
                        child: (widget.data.type == AppConstants.NUOC
                                ? "Nước"
                                : "Thức ăn")
                            .w400(fontSize: 30),
                      ),
                      Expanded(
                          child: widget.data.price
                              .formatMoney()
                              .w400(fontSize: 30))
                    ],
                  ),
                )),
                SizedBox(
                  width: 150,
                  child: Row(
                    spacing: 10,
                    children: [
                      IconButton(
                          onPressed: () {
                            _showDialogEdit(data: widget.data);
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            widget.settingCubit
                                .deleteProduct(hiveId: widget.data.hiveId!);
                          },
                          icon: Icon(Icons.delete))
                    ],
                  ),
                )
              ],
            ),
            Visibility(
                visible: isShowExtra,
                child: Container(
                  width: double.infinity,
                  color: appColors(context).primaryColor25,
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = widget.data.extras?[index];
                          return Container(
                            height: 50,
                            child: Row(
                              spacing: 10,
                              children: [
                                "+${data?.name}".w300(
                                    fontSize: 25,
                                    color: appColors(context).primaryColor75),
                                "${data?.price.formatMoney()}".w300(
                                    fontSize: 25,
                                    color: appColors(context).primaryColor75),
                              ],
                            ),
                          );
                        },
                        itemCount: widget.data.extras?.length ?? 0,
                      )
                    ],
                  ),
                ))
          ],
        ));
  }

  _showDialogEdit({required Product data}) {
    TextEditingController _name = TextEditingController();
    TextEditingController _price = TextEditingController();
    TextEditingController _type = TextEditingController();
    final Map<String, String> valueMap = {
      "Thức ăn": AppConstants.THUC_AN,
      "Nước": AppConstants.NUOC
    };
    final Map<String, String> valueMapParse = {
      AppConstants.THUC_AN: "Thức ăn",
      AppConstants.NUOC: "Nước"
    };
    _name.text = data.name ?? "";
    _price.text = data.price.formatMoney();
    _type.text = valueMapParse[data.type!]!;

    return showDialog(
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setStateDialog) {
              return Dialog(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: 500,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppTextFieldLabel(
                        lable: "Tên món",
                        controller: _name,
                        onChanged: (value) {
                          widget.data.name = value;
                        },
                      ),
                      AppTextFieldLabel(
                        lable: "Giá",
                        controller: _price,
                        onChanged: (value) {
                          widget.data.price = double.parse(value);
                        },
                      ),
                      Expanded(
                          child: AppDropButton(
                        borderRadius: 0,
                        height: 60,
                        lable: "Loại món ăn",
                        items: ["Thức ăn", "Nước"],
                        value: _type.text,
                        onChange: (value) {
                          _type.text = valueMap[value]!;
                          widget.data.type = _type.text;
                        },
                      )),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var data = widget.data.extras?[index];
                                  return ItemExtra(
                                    extra: data!,
                                    onChangeName: (value) {
                                      widget.data.extras?[index].name = value;
                                      widget.settingCubit
                                          .updateProduct(product: widget.data);
                                    },
                                    onChangePrice: (value) {
                                      Future.delayed(Duration(seconds: 2), () {
                                        widget.data.extras?[index].price =
                                            double.parse(value);
                                        widget.settingCubit.updateProduct(
                                            product: widget.data);
                                      });
                                    },
                                    onDelete: () {
                                      setStateDialog(() {
                                        widget.data.extras?.removeWhere(
                                            (e) => e.hiveId == data.hiveId);
                                      });
                                      widget.settingCubit
                                          .updateProduct(product: widget.data);
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(),
                                itemCount: data.extras?.length ?? 0),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setStateDialog(() {
                                  widget.data.extras
                                      ?.add(Extra(hiveId: Uuid().v4()));
                                });
                                widget.settingCubit
                                    .updateProduct(product: widget.data);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(100, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text('Add Item Extra'),
                            ),
                          ],
                        ),
                      )),
                      CustomMaterialButton(
                          onTap: () {
                            widget.settingCubit
                                .updateProduct(product: widget.data);
                            Navigator.pop(context);
                          },
                          height: 60,
                          width: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: appColors(context).primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: "LƯU".w500(
                              fontSize: 25, color: appColors(context).white))
                    ],
                  ),
                ),
              );
            }));
  }
}

class ItemExtra extends StatefulWidget {
  final Extra extra;
  final VoidCallback? onDelete;
  final Function(String value)? onChangeName;
  final Function(String value)? onChangePrice;
  const ItemExtra(
      {required this.extra,
      this.onDelete,
      this.onChangeName,
      this.onChangePrice,
      super.key});

  @override
  State<ItemExtra> createState() => _ItemExtraState();
}

class _ItemExtraState extends State<ItemExtra> {
  final _nameController = TextEditingController();
  final _priceExtra = TextEditingController();
  @override
  void initState() {
    _nameController.text = widget.extra.name ?? "";
    _priceExtra.text = widget.extra.price.formatMoney();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Tên món',
              hintText: 'Enter dish name',
            ),
            onChanged: (value) {
              widget.onChangeName?.call(value);
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: _priceExtra,
            decoration: const InputDecoration(
              labelText: 'Giá trong',
              hintText: '0.00',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              widget.onChangePrice?.call(value);
            },
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            widget.onDelete?.call();
          },
          tooltip: 'Delete',
          color: Colors.red[700],
        ),
      ],
    );
  }
}
