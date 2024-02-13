import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const ProfileTile({
    required this.title,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Icon(icon, size: 20, color: const Color.fromARGB(87, 39, 138, 219)),
      minLeadingWidth: 100,
      title: Text(
        title,
        style: const TextStyle(color: Color.fromARGB(255, 121, 120, 120)),
      ),
    );
  }
}
