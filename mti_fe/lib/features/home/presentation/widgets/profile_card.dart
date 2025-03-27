import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String months;

  const ProfileCard({super.key, required this.name, required this.months});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Material(
            elevation: 5,
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: CircleAvatar(
              radius: 60, // Set a fixed radius
              backgroundColor: Colors.white,
              backgroundImage: const AssetImage('assets/images/baby.png'),
              foregroundImage: const AssetImage('assets/images/baby.png'),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          "is $months old!",
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
