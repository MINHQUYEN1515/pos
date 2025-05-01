import 'package:flutter/material.dart';

class QuantityPopup extends StatefulWidget {
  final Function(int value)? onEmitQuantity;
  final VoidCallback? onClose;
  const QuantityPopup({Key? key, this.onEmitQuantity, this.onClose})
      : super(key: key);

  @override
  State<QuantityPopup> createState() => _QuantityPopupState();
}

class _QuantityPopupState extends State<QuantityPopup> {
  int quantity = 1;

  void increment() {
    setState(() {
      quantity++;
    });
  }

  void decrement() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Chọn số lượng'),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: quantity > 1 ? decrement : null,
                  iconSize: 36,
                  color: Colors.blue,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: increment,
                  iconSize: 36,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('HỦY'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onEmitQuantity?.call(quantity);
            Navigator.pop(context);
          },
          child: const Text('XÁC NHẬN'),
        ),
      ],
    );
  }
}
