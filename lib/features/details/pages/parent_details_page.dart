import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/icon_container.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_button.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_input.dart';

class ParentDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: Icon(
            Icons.chevron_left,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              PrimaryInput(label: 'Name', hintText: 'John'),
              const SizedBox(height: 20),
              PrimaryInput(label: 'Email', hintText: 'john.doe@example.com'),
              const SizedBox(height: 20),
              PrimaryInput(label: 'Address', hintText: 'New Villa'),
              const SizedBox(height: 20),
              PrimaryInput(label: 'Alternate Phone No', hintText: 'Add Phone No'),
              const SizedBox(height: 8),
              PrimaryInput(label: 'Pincode', hintText: 'Add Pincode'),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              PrimaryButton(
                label: 'Continue',
                onTap: () {
                  context.go('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
