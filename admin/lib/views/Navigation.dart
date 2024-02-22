import 'package:admin/views/doctor_list.dart';
import 'package:admin/views/hospital_profile.dart';
import 'package:admin/views/patient_list.dart';
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
     const PatientList1(),
      const DoctorList(),
    const  HospitalProfile(),
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
            icon: const Icon(Icons.format_list_bulleted_sharp),
            title: const Text('Patient List'),
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
