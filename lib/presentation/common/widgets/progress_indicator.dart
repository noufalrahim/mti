import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressIndicatorWidget extends StatelessWidget {

  final Color progressColor;
  final Color backgroundColor;

  const ProgressIndicatorWidget({super.key, required this.backgroundColor, required this.progressColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: LinearPercentIndicator(
        animation: true,
        lineHeight: 20.0,
        animationDuration: 2500,
        percent: 0.8,
        center: const Text("80.0%"),
        linearStrokeCap: LinearStrokeCap.roundAll,
        progressColor: progressColor,
        backgroundColor: backgroundColor,
        barRadius: const Radius.circular(10),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
