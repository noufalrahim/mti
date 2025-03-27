import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/features/milestones/presentation/widgets/stacked_card.dart';

class QuestionCard extends StatelessWidget {
  final String question;
  final String font;
  const QuestionCard({super.key, required this.question, required this.font});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          StackedCard(left: 40, right: 40, top: 0),
          StackedCard(left: 20, right: 20, top: 20),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontFamily: font,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
