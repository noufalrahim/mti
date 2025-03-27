import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:milestone_tracker_of_infants/core/constants/drawer.dart';
import 'package:milestone_tracker_of_infants/core/utils/date_util.dart';
import 'package:milestone_tracker_of_infants/features/home/cubit/child_cubit.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  final int userId;

  const AppDrawer({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final drawerItems = DrawerItems().drawerSettingsItems(context); // FIXED: Pass context

    return Drawer(
      child: BlocBuilder<ChildCubit, ChildState>(
        builder: (context, state) {
          if (state is ChildLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is ChildError) {
            debugPrint(state.error); // Use debugPrint instead of print
            return const Center(child: Text('An error occurred!'));
          }

          if (state is GetChildrenSuccess) {
            final defaultChild = state.defaultChild;
            final List<Map<String, dynamic>> childrenMenuItems = state.children
                .where((child) => child.id != defaultChild?.id)
                .map((child) {
                  return {
                    'icon': Icons.child_care,
                    'title': child.name,
                    'onTap': () async {
                      await context.read<ChildCubit>().editDefaultChild(userId, child.id);
                      if (context.mounted) {
                        context.read<ChildCubit>().loadChildren(userId);
                      }
                    },
                  };
                })
                .toList();

            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      SizedBox(
                        height: 220,
                        child: DrawerHeader(
                          decoration: const BoxDecoration(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Image.asset(
                                'assets/images/baby.png',
                                width: 75,
                                height: 75,
                              ),
                              const SizedBox(height: 15),
                              Text(
                                defaultChild?.name ?? 'No Default Child',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                defaultChild != null
                                    ? DateUtilsHelper.getAgeFormatted(defaultChild.dateOfBirth)
                                    : 'N/A',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            PrimaryCard(itemsList: drawerItems),
                            const SizedBox(height: 10),
                            PrimaryCard(itemsList: childrenMenuItems),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Footer Section
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.settings, size: 20),
                        title: const Text(
                          'Settings',
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.logout, size: 20),
                        title: const Text(
                          'Logout',
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.remove('loggedInUser');

                          if (context.mounted) {
                            Navigator.pop(context); // Close drawer
                            context.go('/signup'); // Navigate to signup
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox(height: 10);
        },
      ),
    );
  }
}
