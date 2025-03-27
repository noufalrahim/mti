import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/icon_container.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconContainer(),
              SizedBox(height: 30,),
              Text('Tiny Steps',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                  fontFamily: 'KleeOne'
                ),
              ),
              SizedBox(height: 30,),
              Text('"Not just for newborn babies, but for newborn parents too!"',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  fontFamily: 'KleeOne'
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
        child: PrimaryButton(
          label: 'Continue',
          onTap: () {
            context.go('/');
          },
        )
      ),
    );
  }
}