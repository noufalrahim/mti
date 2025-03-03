import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/core/theme/app_theme.dart';
import 'package:milestone_tracker_of_infants/features/auth/pages/signup_page.dart';
import 'package:milestone_tracker_of_infants/features/home/pages/home_page.dart';
import 'package:milestone_tracker_of_infants/features/milestones/pages/milestones_page.dart';
import 'package:milestone_tracker_of_infants/features/settings/pages/settings_page.dart';
import 'package:milestone_tracker_of_infants/features/welcome/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: MilestonesPage(),
    );
  }
}
