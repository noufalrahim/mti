import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/items_card.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Container(child: ItemsCard()),
    );
  }
}
