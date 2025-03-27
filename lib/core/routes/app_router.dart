import 'package:go_router/go_router.dart';
import 'package:milestone_tracker_of_infants/features/auth/pages/signup_page.dart';
import 'package:milestone_tracker_of_infants/features/calendar/pages/calendar_page.dart';
import 'package:milestone_tracker_of_infants/features/details/pages/details_page.dart';
import 'package:milestone_tracker_of_infants/features/details/pages/parent_details_page.dart';
import 'package:milestone_tracker_of_infants/features/home/pages/home_page.dart';
import 'package:milestone_tracker_of_infants/features/milestones/pages/milestones_page.dart';
import 'package:milestone_tracker_of_infants/features/settings/pages/settings_page.dart';
import 'package:milestone_tracker_of_infants/features/welcome/pages/welcome_page.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/bottom_nav_scaffold.dart';

class AppRouter {
  static GoRouter createRouter({
    required bool isAuthenticated,
    required bool isChildrenAvailable,
    required int userId,
  }) {
    print(isChildrenAvailable);
    return GoRouter(
      initialLocation: isAuthenticated
          ? (isChildrenAvailable ? '/' : '/details')
          : '/signup',
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) {
            print("USERID ${state.extra}");
            final passedUserId = state.extra as int? ?? userId;
            return BottomNavScaffold(child: HomePage(userId: passedUserId));
          },
        ),
        GoRoute(
          path: '/milestones',
          name: 'milestones',
          builder: (context, state) => BottomNavScaffold(child: MilestonesPage()),
        ),
        // GoRoute(
        //   path: '/calendar',
        //   name: 'calendar',
        //   builder: (context, state) => BottomNavScaffold(child: CalendarPage()),
        // ),
        GoRoute(
          path: '/settings',
          name: 'settings',
          builder: (context, state) => BottomNavScaffold(child: SettingsPage()),
        ),
        GoRoute(
          path: '/welcome',
          name: 'welcome',
          builder: (context, state) => WelcomePage(),
        ),
        GoRoute(
          path: '/signup',
          name: 'signup',
          builder: (context, state) => SignupPage(),
        ),
        GoRoute(
          path: '/details',
          name: 'details',
          builder: (context, state) {
            final passedUserId = state.extra as int? ?? userId;
            return DetailsPage(userId: passedUserId);
          },
        ),
        GoRoute(
          path: '/more-info',
          name: 'moreInfo',
          builder: (context, state) => ParentDetailsPage(),
        ),
      ],
    );
  }
}
