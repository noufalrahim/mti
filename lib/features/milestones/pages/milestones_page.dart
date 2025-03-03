import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/features/milestones/presentation/widgets/category_container.dart';
import 'package:milestone_tracker_of_infants/features/milestones/presentation/widgets/question_card.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/progress_indicator.dart';

class MilestonesPage extends StatelessWidget {
  const MilestonesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Milestones')),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryContainer(
                      label: 'Social',
                      onTap: () {},
                      color: Colors.red,
                    ),
                    CategoryContainer(
                      label: 'Language',
                      onTap: () {},
                      color: Colors.blue,
                    ),
                    CategoryContainer(
                      label: 'Movement',
                      onTap: () {},
                      color: Colors.yellow.shade700,
                    ),
                    CategoryContainer(
                      label: 'Cognitive',
                      onTap: () {},
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ProgressIndicatorWidget(progressColor: Color(0xFF6EFF66), backgroundColor: Color(0xFFCBF4CC),),
              SizedBox(height: 20,),
              QuestionCard()
            ],
          ),
        ),
      ),
    );
  }
}
