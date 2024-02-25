import 'package:doctro_user/views/booked_details.dart';
import 'package:doctro_user/views/user_home.dart';
import 'package:doctro_user/views/user_profile.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    List pages = [
      const BookDetails(date: '', drName: '', time: ''),
      const UserHome(),
      const UserProfile(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: FlashyTabBar(
        backgroundColor: Colors.white,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.event),
            title: const Text('Booked Details'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Profile'),
          ),
        ],
      ),
    );
  }
}
