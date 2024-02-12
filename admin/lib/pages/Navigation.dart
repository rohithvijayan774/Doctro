import 'package:admin/pages/doctor_list.dart';
import 'package:admin/pages/hospital_profile.dart';
import 'package:admin/pages/patient_list.dart';
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
      PatientList1(),
      DoctorList(),
      HospitalProfile(),
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
            icon: Icon(Icons.format_list_bulleted_sharp),
            title: Text('Patient List'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
