import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone_tracker_of_infants/core/routes/app_router.dart';
import 'package:milestone_tracker_of_infants/core/theme/app_theme.dart';
import 'package:milestone_tracker_of_infants/features/auth/cubit/auth_cubit.dart';
import 'package:milestone_tracker_of_infants/features/home/cubit/child_cubit.dart';
import 'package:milestone_tracker_of_infants/features/home/cubit/child_response_cubit.dart';
import 'package:milestone_tracker_of_infants/features/home/repository/child_repository.dart';
import 'package:milestone_tracker_of_infants/features/milestones/cubit/category_cubit.dart';
import 'package:milestone_tracker_of_infants/features/milestones/cubit/questions_cubit.dart';
import 'package:milestone_tracker_of_infants/models/child_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('loggedInUser');

  var loggedInUser = jsonString != null ? jsonDecode(jsonString) : null;
  print("LOGGEDIN $loggedInUser");

  try {
    final childRepository = ChildRepository();
    List<ChildModel> childrenList = [];

    if (loggedInUser?['id'] != null) {
      childrenList = await childRepository.getChildrenByUser(loggedInUser['id']);
    }

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit()),
          BlocProvider(create: (_) => CategoryCubit()),
          BlocProvider(create: (_) => ChildResponseCubit()),
          BlocProvider(create: (_) => QuestionsCubit()),
          BlocProvider(
            create: (_) {
              return ChildCubit(childRepository)
                ..loadChildren(loggedInUser?['id'] ?? 0);
            },
          ),
        ],
        child: MyApp(
          isAuthenticated: loggedInUser != null,
          isChildrenAvailable: childrenList.isNotEmpty,
          userId: loggedInUser?['id'] ?? 0,
        ),
      ),
    );
  } catch (e, stackTrace) {
    print("Error during initialization: $e");
    print(stackTrace);
  }
}

class MyApp extends StatelessWidget {
  final bool isAuthenticated;
  final bool isChildrenAvailable;
  final int userId;

  const MyApp({
    super.key,
    required this.isAuthenticated,
    required this.isChildrenAvailable,
    required this.userId
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      routerConfig: AppRouter.createRouter(
        isAuthenticated: isAuthenticated,
        isChildrenAvailable: isChildrenAvailable,
        userId: userId
      ),
    );
  }
}
