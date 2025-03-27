import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/features/calendar/presentation/widget/timeline.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        automaticallyImplyLeading: false
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TimelineWidget(),
        ),
      ),
    );
  }
}