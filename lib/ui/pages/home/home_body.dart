import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  // Table statuses
  final Map<String, TableStatus> tableStatuses = {
    '001': TableStatus.available,
    '002': TableStatus.empty,
    '003': TableStatus.occupied,
    '004': TableStatus.empty,
    '005': TableStatus.occupied,
    '006': TableStatus.empty,
    '007': TableStatus.empty,
    '005': TableStatus.occupied,
    '102': TableStatus.occupied,
    '008': TableStatus.empty,
    '009': TableStatus.occupied,
    '103': TableStatus.occupied,
    '010': TableStatus.empty,
    '104': TableStatus.empty,
    '011': TableStatus.empty,
    '012': TableStatus.empty,
    '013': TableStatus.empty,
    '105': TableStatus.empty,
    '014': TableStatus.empty,
    '015': TableStatus.empty,
    '016': TableStatus.empty,
    '106': TableStatus.empty,
    '017': TableStatus.empty,
    '018': TableStatus.empty,
    '019': TableStatus.empty,
    '107': TableStatus.empty,
    '301': TableStatus.occupied,
    '302': TableStatus.occupied,
    '303': TableStatus.occupied,
    '304': TableStatus.empty,
    '305': TableStatus.empty,
    '306': TableStatus.occupied,
  };

  // Table timing data
  final Map<String, String> tableTimes = {
    '001': '00:30',
    '003': '00:15',
    '005': '00:30',
    '102': '00:41',
    '009': '00:23',
    '103': '00:45',
    '301': '01:30',
    '303': '00:10',
    '306': '00:10',
  };

  // Table size identifiers (for rectangular tables)
  final Set<String> largeRectTables = {'101', '105', '107', '104', '106'};

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
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: const Color(0xFF22555D),
                  child: const Center(
                    child: Text(
                      'Tất cả bàn (30)',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: const Color(0xFF9EACAD),
                  child: const Center(
                    child: Text(
                      'Bàn trống',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: const Color(0xFF9EACAD),
                  child: const Center(
                    child: Text(
                      'Có khách',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Tables grid
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // First row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTable('001', isLargeRect: false),
                      buildTable('002', isLargeRect: false),
                      buildTable('101', isLargeRect: true),
                      buildTable('003', isLargeRect: false),
                      buildTable('004', isLargeRect: false),
                      buildTable('005', isLargeRect: false),
                      buildTable('006', isLargeRect: false),
                      buildTable('007', isLargeRect: false),
                      buildTable('005', isLargeRect: false),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Second row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTable('102', isLargeRect: true, width: 2),
                      buildTable('008', isLargeRect: false),
                      buildTable('009', isLargeRect: false),
                      buildTable('103', isLargeRect: true, width: 2),
                      buildTable('010', isLargeRect: false),
                      buildTable('104', isLargeRect: true, width: 2),
                      buildTable('011', isLargeRect: false),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Third row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTable('012', isLargeRect: false),
                      buildTable('013', isLargeRect: false),
                      buildTable('105', isLargeRect: true),
                      buildTable('014', isLargeRect: false),
                      buildTable('015', isLargeRect: false),
                      buildTable('016', isLargeRect: false),
                      buildTable('106', isLargeRect: true),
                      buildTable('017', isLargeRect: false),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Fourth row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildTable('018', isLargeRect: false),
                      buildTable('019', isLargeRect: false),
                      buildTable('107', isLargeRect: true),
                      buildTable('301', isLargeRect: false),
                      buildTable('302', isLargeRect: false),
                      buildTable('303', isLargeRect: false),
                      buildTable('304', isLargeRect: false),
                      buildTable('305', isLargeRect: false),
                      buildTable('306', isLargeRect: false),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // Bottom navigation
        Container(
          color: const Color(0xFF22555D),
          child: Row(
            children: [
              buildNavButton('Khu vực 1'),
              buildNavButton('Khu vực 2'),
              buildNavButton('Mang về'),
              const Spacer(),
              buildNavButton('Số dự bàn', icon: Icons.assignment),
              buildNavButton('Thanh toán', icon: Icons.payment),
              buildNavButton('Đặt/giữ bàn', icon: Icons.event_seat),
              buildNavButton('Hóa đơn', icon: Icons.receipt),
              buildNavButton('Bàn phím', icon: Icons.keyboard),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTable(String tableNumber,
      {bool isLargeRect = false, double width = 1}) {
    final status = tableStatuses[tableNumber] ?? TableStatus.empty;
    final tableTime = tableTimes[tableNumber] ?? '';

    Color tableColor;
    Color textColor = Colors.black;

    switch (status) {
      case TableStatus.occupied:
        tableColor = const Color(0xFF22555D);
        textColor = Colors.white;
        break;
      case TableStatus.available:
        tableColor = const Color(0xFF22555D);
        textColor = Colors.white;
        break;
      case TableStatus.empty:
      default:
        tableColor = Colors.white;
    }

    return Container(
      width: isLargeRect ? 180 : 80 * width,
      height: isLargeRect ? 80 : 80,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: tableColor,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            tableNumber,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          if (tableTime.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                tableTime,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                ),
              ),
            ),
          if (tableNumber == '301' && tableTime.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                '(đặt trước)',
                style: TextStyle(
                  color: textColor.withOpacity(0.8),
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildNavButton(String title, {IconData? icon}) {
    return Container(
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
