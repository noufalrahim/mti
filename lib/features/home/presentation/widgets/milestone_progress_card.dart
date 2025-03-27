import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/core/utils/total_progress_calculator.dart';
import 'package:milestone_tracker_of_infants/features/home/presentation/widgets/status_progress_bar.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MilestoneProgressCard extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const MilestoneProgressCard({super.key, required this.data});
  
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
                    lineWidth: 12.0,
                    percent: TotalProgressCalculator.calculateMilestoneProgress(data),
                    center: Text(
                      '${TotalProgressCalculator.calculateMilestoneProgress(data)*100}%',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    progressColor: Colors.blueAccent,
                    backgroundColor: Colors.grey[100]!,
                    circularStrokeCap: CircularStrokeCap.round
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: data.map((item) => StatusProgressBar(
                        categoryProgress: item,
                      )).toList(),
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
