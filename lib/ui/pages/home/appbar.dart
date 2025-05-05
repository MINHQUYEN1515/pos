import 'package:flutter/material.dart';
import 'package:pos/core/constants/local_constants.dart';
import 'package:pos/core/routes/app_route.dart';
import 'package:pos/data/local_model/local_model.dart';
import 'package:pos/state_manager/state_manager.dart';

class HomeAppBar extends StatefulWidget {
  final HomeCubit homeCubit;
  const HomeAppBar(this.homeCubit, {super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  int _selectedIndex = 1;

  List<NavigationItem> _navigationItems = [];
  @override
  void initState() {
    super.initState();
    _navigationItems.addAll([
      NavigationItem(
          id: 1,
          icon: Icons.settings,
          label: 'Settings',
          isActive: widget.homeCubit.user?.permission == Permission.admin),
      NavigationItem(
          id: 2,
          icon: Icons.restaurant,
          label: 'Restaurant',
          isSelected: true,
          isActive: widget.homeCubit.user?.permission == Permission.user),
      NavigationItem(
          id: 3,
          icon: Icons.change_circle,
          label: 'Đổi bàn',
          isActive: widget.homeCubit.user?.permission == Permission.user),
      NavigationItem(
          id: 4,
          icon: Icons.merge_outlined,
          label: 'Gộp bàn',
          isActive: widget.homeCubit.user?.permission == Permission.user),
      NavigationItem(
          id: 5,
          icon: Icons.table_chart,
          label: 'Doanh thu',
          isActive: widget.homeCubit.user?.permission == Permission.admin),
      NavigationItem(
        id: 6,
        icon: Icons.logout,
        label: 'Đăng xuất',
        isActive: true,
        callback: () {
          widget.homeCubit.logout(context).then((value) {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          });
        },
      ),
    ]);
    _selectedIndex =
        widget.homeCubit.user?.permission == Permission.admin ? 5 : 2;
    _navigationItems = _navigationItems.where((e) => e.isActive).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Column(
        children: [
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            color: Colors.grey[200],
            child: const Text(
              'POS - NHÀ HÀNG ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ),
          // Main navigation bar
          Container(
            height: 60,
            color: const Color(0xFF0D3B49),
            child: Row(
              children: [
                // Menu button
                Container(
                  width: 60,
                  color: const Color(0xFF0D3B49),
                  child: IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                // Navigation items
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _navigationItems.length,
                    itemBuilder: (context, index) {
                      return _buildNavigationItem(
                          _navigationItems[index], index);
                    },
                  ),
                ),
                // Right side icons
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white38),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.access_time,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '12:30',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white38),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '29.10.2024',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white38),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.language,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            'Vietnamese',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 16,
                        child:
                            Icon(Icons.person, color: Colors.black, size: 20),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      margin: const EdgeInsets.only(left: 8, right: 16),
                      child: Text(
                        '${widget.homeCubit.user?.username}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Main content area
        ],
      ),
    );
  }

  Widget _buildNavigationItem(NavigationItem item, int index) {
    bool isSelected = item.id == _selectedIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = item.id;
        });
        if (item.id != 6) {
          widget.homeCubit.changeScreen(AppConstants.screenMap[item.id]!);
        } else {
          item.callback?.call();
        }
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFF0D3B49),
          border: Border(
            right: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: isSelected ? const Color(0xFF0D3B49) : Colors.white,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF0D3B49) : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationItem {
  final int id;
  final IconData icon;
  final String label;
  final bool isSelected;
  final bool isActive;
  final VoidCallback? callback;

  NavigationItem(
      {required this.id,
      required this.icon,
      required this.label,
      this.isSelected = false,
      this.isActive = false,
      this.callback});
}
