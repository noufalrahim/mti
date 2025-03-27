import 'package:flutter/material.dart';

class SettingsItems {
  final List<Map<String, dynamic>> generalSettings = [
    {
      'icon': Icons.notification_add,
      'title': 'Notification',
      'onTap': () {
        // Add functionality for Notification
      },
    },
    {
      'icon': Icons.language,
      'title': 'Language',
      'onTap': () {
        // Add functionality for Language change
      },
    },
    {
      'icon': Icons.star,
      'title': 'Rate App',
      'onTap': () {
        // Add functionality for Rate App
      },
    },
    {
      'icon': Icons.share,
      'title': 'Share App',
      'onTap': () {
        // Add functionality for Share App
      },
    },
  ];

  final List<Map<String, dynamic>> legalSettings = [
    {
      'icon': Icons.privacy_tip,
      'title': 'Privacy Policy',
      'onTap': () {
        // Add functionality for Privacy Policy
      },
    },
    {
      'icon': Icons.file_copy,
      'title': 'Terms & Conditions',
      'onTap': () {
        // Add functionality for Terms & Conditions
      },
    },
  ];

  final List<Map<String, dynamic>> accountSettings = [
    {
      'icon': Icons.mail,
      'title': 'Contact Us',
      'onTap': () {
        // Add functionality for Contact Us
      },
    },
    {
      'icon': Icons.delete,
      'title': 'Delete Account',
      'onTap': () {
        // Add functionality for Delete Account
      },
    },
  ];
}
