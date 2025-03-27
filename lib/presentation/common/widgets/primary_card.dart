import 'package:flutter/material.dart';

class PrimaryCard extends StatelessWidget {
  final List<Map<String, dynamic>> itemsList;

  const PrimaryCard({super.key, required this.itemsList});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:
            itemsList.map((item) {
              return ListTile(
                leading: Icon(item['icon'] as IconData),
                title: Text(item['title'] as String),
                onTap: item['onTap'] as VoidCallback? ?? () {},
              );
            }).toList(),
      ),
    );
  }
}
