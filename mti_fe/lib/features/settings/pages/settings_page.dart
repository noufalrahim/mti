import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/core/constants/settings.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final generalSettings = SettingsItems().generalSettings;
    final legalSettings = SettingsItems().legalSettings;
    final accountSettings = SettingsItems().accountSettings;

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          children: [
            PrimaryCard(itemsList: generalSettings),
            SizedBox(height: 24),
            PrimaryCard(itemsList: legalSettings),
            SizedBox(height: 24,),
            PrimaryCard(itemsList: accountSettings)
          ],
        ),
      ),
    );
  }
}
