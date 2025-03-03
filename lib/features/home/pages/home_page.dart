import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/features/home/presentation/widgets/milestone_progress_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Home'),
      ),
      body: MilestoneProgressCard(),
    );
  }
}