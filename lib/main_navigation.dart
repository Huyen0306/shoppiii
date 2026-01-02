import 'package:flutter/material.dart';
import 'core/widgets/floating_bottom_nav_bar.dart';
import 'features/home/pages/home_page.dart';
import 'features/mall/pages/mall_page.dart';
import 'features/live/pages/live_page.dart';
import 'features/notifications/pages/notifications_page.dart';
import 'features/profile/pages/profile_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const MallPage(),
    const LivePage(),
    const NotificationsPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: FloatingBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
