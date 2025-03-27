import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/progress_indicator.dart';

class StatusProgressBar extends StatelessWidget {
  final Map<String, dynamic> categoryProgress; // Explicitly define as a Map

  const StatusProgressBar({
    super.key,
    required this.categoryProgress,
  });

  @override
  Widget build(BuildContext context) {
    final progressData =
        categoryProgress['progress'] ?? {}; // Get progress as a Map
    final int totalQuestions = progressData['totalQuestions'] ?? 0;
    final int answeredYes = progressData['answeredYes']?.length ?? 0;
    final int answeredNo = progressData['answeredNo']?.length ?? 0;
    final double progress =
        totalQuestions != 0
            ? ((answeredNo + answeredYes)) / totalQuestions
            : 0;

    final String answeredRatio = "${(answeredYes + answeredNo)}/$totalQuestions";

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProgressIndicatorWidget(
            progress: progress,
            progressText: "${(progress * 100).toInt()}%", // Format percentage
            backgroundColor: const Color(0xFFE8F8FE),
            progressColor: const Color(0xFF5DCCFC),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    categoryProgress['category'] ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(answeredRatio),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
