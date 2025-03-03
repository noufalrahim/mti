import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/features/home/presentation/widgets/status_progress_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MilestoneProgressCard extends StatelessWidget {
  const MilestoneProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Milestone Checklist',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircularPercentIndicator(
                    radius: 60,
                    lineWidth: 8.0,
                    percent: 0.3,
                    center: Text(
                      '30%',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    progressColor: Colors.blueAccent,
                    backgroundColor: Colors.grey[300]!,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: List.generate(
                        5,
                        (index) => const StatusProgressBar(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/images/confetti.png',
                width: 75,
                height: 75,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
