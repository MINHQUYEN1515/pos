import 'package:flutter/material.dart';
import 'package:pos/extensions/textstyle_extension.dart';
import 'package:pos/state_manager/state_manager.dart';
import 'package:pos/theme/colors.dart';
import 'package:pos/ui/widgets/button/custom_material_button.dart';

class MergeTableKey extends StatefulWidget {
  final VoidCallback? onClose;
  final TableDetailCubit? tableDetailCubit;
  final HomeCubit homeCubit;
  const MergeTableKey(this.tableDetailCubit, this.homeCubit,
      {super.key, this.onClose});

  @override
  State<MergeTableKey> createState() => _MergeTableKeyState();
}

class _MergeTableKeyState extends State<MergeTableKey> {
  TextEditingController _fromTable = TextEditingController();
  TextEditingController _toTable = TextEditingController();
  bool _choose = false;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button at top right
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        widget.onClose?.call();
                      },
                    ),
                  ),
                  // From/To boxes
                  Row(
                    children: [
                      Expanded(
                        child: _buildFromToBox("From", !_choose,
                            controller: _fromTable, onTap: () {
                          setState(() {
                            _choose = false;
                          });
                        }),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildFromToBox("To", _choose,
                            controller: _toTable, onTap: () {
                          setState(() {
                            _choose = true;
                          });
                        }),
                      ),
                    ],
                  ),

                  Column(
                    spacing: 5,
                    children: [
                      Row(
                        spacing: 5,
                        children: [
                          Expanded(
                            child: _keyboard(context, name: "1", onClick: () {
                              _enterPassword("1");
                            }),
                          ),
                          Expanded(
                            child: _keyboard(context, name: "2", onClick: () {
                              _enterPassword("2");
                            }),
                          ),
                          Expanded(
                            child: _keyboard(context, name: "3", onClick: () {
                              _enterPassword("3");
                            }),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          Expanded(
                            child: _keyboard(context, name: "4", onClick: () {
                              _enterPassword("4");
                            }),
                          ),
                          Expanded(
                            child: _keyboard(context, name: "5", onClick: () {
                              _enterPassword("5");
                            }),
                          ),
                          Expanded(
                            child: _keyboard(context, name: "6", onClick: () {
                              _enterPassword("6");
                            }),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          Expanded(
                            child: _keyboard(context, name: "7", onClick: () {
                              _enterPassword("7");
                            }),
                          ),
                          Expanded(
                            child: _keyboard(context, name: "8", onClick: () {
                              _enterPassword("8");
                            }),
                          ),
                          Expanded(
                            child: _keyboard(context, name: "9", onClick: () {
                              _enterPassword("9");
                            }),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 5,
                        children: [
                          Expanded(
                            child: _keyboard(context, name: ",", onClick: () {
                              _enterPassword(",");
                            }),
                          ),
                          Expanded(
                            child: _keyboard(context, name: "0", onClick: () {
                              _enterPassword("0");
                            }),
                          ),
                          Expanded(
                              child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Colors.black
                                          .withOpacity(0.3), // Màu bóng
                                      spreadRadius:
                                          0, // Không lan rộng ra nhiều
                                      blurRadius: 2, // Độ mờ của bóng
                                      offset: Offset(
                                          0, 3), // Chỉ đổ bóng xuống dưới
                                    ),
                                  ]),
                                ),
                              ),
                              CustomMaterialButton(
                                  onTap: () {
                                    widget.tableDetailCubit?.mergeTable(
                                        strTableFrom: _fromTable.text,
                                        tableTo: _toTable.text);
                                    widget.homeCubit.fetchData();
                                    setState(() {});
                                    _fromTable.text = '';
                                    _toTable.text = '';
                                  },
                                  height: 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: appColors(context).grey),
                                    borderRadius: BorderRadius.circular(5),
                                    color: appColors(context).primaryColor,
                                  ),
                                  child: Icon(
                                    Icons.change_circle,
                                    color: appColors(context).white,
                                  )),
                            ],
                          )),
                        ],
                      ),
                      Container(
                          child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color:
                                      Colors.black.withOpacity(0.3), // Màu bóng
                                  spreadRadius: 0, // Không lan rộng ra nhiều
                                  blurRadius: 2, // Độ mờ của bóng
                                  offset:
                                      Offset(0, 3), // Chỉ đổ bóng xuống dưới
                                ),
                              ]),
                            ),
                          ),
                          CustomMaterialButton(
                              onTap: () {
                                if (!_choose) {
                                  if (_fromTable.text != null &&
                                      _fromTable.text != '') {
                                    _fromTable.text = _fromTable.text.substring(
                                        0, _fromTable.text.length - 1);
                                  }
                                } else {
                                  if (_toTable.text != null &&
                                      _toTable.text != '') {
                                    _toTable.text = _toTable.text
                                        .substring(0, _toTable.text.length - 1);
                                  }
                                }
                                setState(() {});
                              },
                              height: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: appColors(context).grey),
                                borderRadius: BorderRadius.circular(5),
                                color: appColors(context).primaryColor,
                              ),
                              child: Icon(
                                Icons.backspace,
                                color: appColors(context).white,
                              )),
                        ],
                      )),
                    ],
                  ),
                ],
              ),
            )));
  }

  void _enterPassword(String text) {
    if (!_choose) {
      _fromTable.text = _fromTable.text + text;
    } else {
      _toTable.text = _toTable.text + text;
    }
    setState(() {});
  }

  Widget _keyboard(context, {required String name, VoidCallback? onClick}) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Màu bóng
                spreadRadius: 0, // Không lan rộng ra nhiều
                blurRadius: 2, // Độ mờ của bóng
                offset: Offset(0, 3), // Chỉ đổ bóng xuống dưới
              ),
            ]),
          ),
        ),
        CustomMaterialButton(
            onTap: () {
              onClick?.call();
            },
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(color: appColors(context).grey),
                borderRadius: BorderRadius.circular(5),
                color: appColors(context).white),
            child: "$name".w500(fontSize: 30)),
      ],
    );
  }

  Widget _buildFromToBox(String title, bool isChoose,
      {required TextEditingController controller, VoidCallback? onTap}) {
    return CustomMaterialButton(
      onTap: () {
        onTap?.call();
      },
      decoration: BoxDecoration(
          color: title == "From"
              ? const Color(0xFF1A4D50)
              : const Color(0xFF3A6A6D),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isChoose
                  ? appColors(context).red
                  : appColors(context).transparent)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              controller.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: title == "From"
                    ? const Color(0xFF1A4D50)
                    : const Color(0xFF1A4D50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
