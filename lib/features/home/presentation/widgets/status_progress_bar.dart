import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/progress_indicator.dart';

class StatusProgressBar extends StatelessWidget {
  const StatusProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProgressIndicatorWidget(
            backgroundColor: const Color(0xFFE8F8FE),
            progressColor: const Color(0xFF5DCCFC),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text('Social', overflow: TextOverflow.ellipsis),
                ),
                Text('11/12'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
