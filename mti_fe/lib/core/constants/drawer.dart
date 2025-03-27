import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerItems {
  List<Map<String, dynamic>> drawerSettingsItems(BuildContext context) => [
        {
          'icon': Icons.add,
          'title': 'Add Child',
          'onTap': () => context.go('/details'),
        },
        {
          'icon': Icons.add,
          'title': 'Add More Info',
          'onTap': () => context.go('/more-info'),
        }
      ];

  List<Map<String, dynamic>> drawerAppSettingsItems(BuildContext context) => [
        {
          'icon': Icons.account_circle,
          'title': 'Liam Doe',
          'onTap': () => context.go('/profile/liam'),
        },
        {
          'icon': Icons.account_circle,
          'title': 'Olivia Jones',
          'onTap': () => context.go('/profile/olivia'),
        },
      ];
}
