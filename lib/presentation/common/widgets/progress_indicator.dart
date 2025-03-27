import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressIndicatorWidget extends StatelessWidget {

  final Color progressColor;
  final Color backgroundColor;
  final double progress;
  final String progressText;

  const ProgressIndicatorWidget({super.key, required this.backgroundColor, required this.progressColor, required this.progress, required this.progressText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: LinearPercentIndicator(
        animation: true,
        lineHeight: 20.0,
        animationDuration: 2500,
        percent: progress,
        center: Text(progressText),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: progressColor,
        backgroundColor: backgroundColor,
        barRadius: const Radius.circular(10),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
