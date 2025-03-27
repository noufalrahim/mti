import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavScaffold extends StatelessWidget {
  final Widget child;
  const BottomNavScaffold({super.key, required this.child});

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    switch (location) {
      case '/milestones':
        return 1;
      case '/settings':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents layout issues
      body: Stack(
        children: [
          Positioned.fill(child: child), // Ensures child takes full screen
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures icons stay visible
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue, // Customize selected icon color
        unselectedItemColor: Colors.grey, // Customize unselected icon color
        showUnselectedLabels: true, // Ensures labels appear
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/milestones');
              break;
            case 2:
              context.go('/settings');
              break;
        
            
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Milestones'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.calendar_today),
          //   label: 'Calendar',
          // ),
          
        ],
      ),
    );
  }
}
