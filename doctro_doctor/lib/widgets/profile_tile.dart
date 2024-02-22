import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const ProfileTile({
    required this.icon,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 25,
            color: Colors.blue[100],
          ),
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
        const Divider(
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}
