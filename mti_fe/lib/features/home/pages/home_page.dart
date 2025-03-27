import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone_tracker_of_infants/core/utils/date_util.dart';
import 'package:milestone_tracker_of_infants/features/home/cubit/child_cubit.dart';
import 'package:milestone_tracker_of_infants/features/home/cubit/child_response_cubit.dart';
import 'package:milestone_tracker_of_infants/features/home/presentation/widgets/app_drawer.dart';
import 'package:milestone_tracker_of_infants/features/home/presentation/widgets/button_widget.dart';
import 'package:milestone_tracker_of_infants/features/home/presentation/widgets/info_card.dart';
import 'package:milestone_tracker_of_infants/features/home/presentation/widgets/milestone_progress_card.dart';
import 'package:milestone_tracker_of_infants/features/home/presentation/widgets/profile_card.dart';

class HomePage extends StatefulWidget {
  final int userId;
  HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> buttons = [
    {
      'color': Color(0xFFB3E5FC),
      'icon': Icons.info,
      'label': 'When to act early',
      'onTap': () {},
    },
    {
      'color': Color(0xFFF8BBD0),
      'icon': Icons.star,
      'label': "My Child's Summary",
      'onTap': () {},
    },
    {
      'color': Color(0xFFAED581),
      'icon': Icons.abc,
      'label': 'Tips & Activities',
      'onTap': () {},
    },
    {
      'color': Color(0xFFD1C4E9),
      'icon': Icons.book,
      'label': 'Helpful Resources',
      'onTap': () {},
    },
    {
      'color': Color(0xFFFFCCBC),
      'icon': Icons.schedule,
      'label': 'Track Milestones',
      'onTap': () {},
    },
    {
      'color': Color(0xFF80DEEA),
      'icon': Icons.help,
      'label': 'Get Support',
      'onTap': () {},
    },
  ];

  @override
  void initState() {
    super.initState();
    context.read<ChildCubit>().loadChildren(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    print(" Userid ${widget.userId}");
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          },
        ),
        title: Text('Home'),
      ),
      drawer: AppDrawer(userId: widget.userId),
      body: BlocListener<ChildCubit, ChildState>(
        listener: (context, state) {
          if (state is GetChildrenSuccess) {
            context.read<ChildResponseCubit>().setChildId(
              state.defaultChild.id,
            );
          }
          if (state is AddNewChildSuccess) {
            context.read<ChildCubit>().loadChildren(widget.userId);
          }
        },
        child: BlocBuilder<ChildCubit, ChildState>(
          builder: (context, state) {
            print(state);
            if (state is ChildLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            if (state is ChildError) {
              return const Center(child: Text('An error occurred!1'));
            
            }
            if (state is GetChildrenSuccess) {
              return BlocBuilder<ChildResponseCubit, ChildResponseState>(
                builder: (context, childResponseState) {
                  if (childResponseState is ChildResponseLoading) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  }

                  if (childResponseState is ChildResponseError) {
                    print(childResponseState.error);
                    return const Center(child: Text('An error occurred!2'));
                  }

                  if (childResponseState is GetChildProgress) {
                    final List<Map<String, dynamic>> milestoneData =
                        (childResponseState.childProgress as List)
                            .map((e) => e as Map<String, dynamic>)
                            .toList();
                    
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ProfileCard(
                            name: state.defaultChild.name,
                            months: DateUtilsHelper.getAgeFormatted(
                              state.defaultChild.dateOfBirth,
                            ),
                          ),
                          SizedBox(height: 10),
                          InfoCard(),
                          SizedBox(height: 20),
                          MilestoneProgressCard(data: milestoneData),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SizedBox(
                              height: 250,
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                      childAspectRatio: 1,
                                    ),
                                itemCount: buttons.length,
                                itemBuilder: (context, index) {
                                  return ButtonWidget(
                                    label: buttons[index]['label'],
                                    icon: buttons[index]['icon'],
                                    onTap: buttons[index]['onTap'],
                                    color: buttons[index]['color'],
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container(height: 10, color: Colors.red,);
                },
              );
            }
            return Container(height: 10, color: Colors.yellow,);
          },
        ),
      ),
    );
  }
}
