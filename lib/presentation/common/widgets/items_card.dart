import 'package:flutter/material.dart';

class ItemsCard extends StatelessWidget {
  const ItemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias, 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _notificationTile(),
            _notificationTile(),
            _notificationTile(),
            _notificationTile(),
          ],
        ),
      ),
    );
  }

  Widget _notificationTile() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          child: Row(
            children: [
              Icon(Icons.notification_add_outlined),
              SizedBox(width: 10),
              Text('Notification', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
