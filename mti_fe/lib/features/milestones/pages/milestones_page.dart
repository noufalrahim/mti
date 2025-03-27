import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone_tracker_of_infants/features/home/cubit/child_cubit.dart';
import 'package:milestone_tracker_of_infants/features/home/cubit/child_response_cubit.dart';
import 'package:milestone_tracker_of_infants/features/milestones/cubit/category_cubit.dart';
import 'package:milestone_tracker_of_infants/features/milestones/cubit/questions_cubit.dart';
import 'package:milestone_tracker_of_infants/features/milestones/presentation/widgets/category_container.dart';
import 'package:milestone_tracker_of_infants/features/milestones/presentation/widgets/options_row.dart';
import 'package:milestone_tracker_of_infants/features/milestones/presentation/widgets/question_card.dart';
import 'package:milestone_tracker_of_infants/models/category_model.dart';

class MilestonesPage extends StatefulWidget {
  const MilestonesPage({super.key});

  @override
  State<MilestonesPage> createState() => _MilestonesPageState();
}

class _MilestonesPageState extends State<MilestonesPage> {
  int currentIndex = 0;
  String currentLanguage = 'en';
  CategoryModel? currentCategory;
  int? childId;

  @override
  void initState() {
    super.initState();
    if (childId != null) {
      context.read<ChildResponseCubit>().getChildProgress(childId!);
    }
    context.read<CategoryCubit>().getAllCategories();
  }

  void updateCategory(CategoryModel category) {
    if (currentCategory?.id != category.id) {
      setState(() {
        currentCategory = category;
        currentIndex = 0;
      });
      context.read<QuestionsCubit>().getQuestionsByCategory(category.id);
    }
  }

  void changeQuestionIndex(int delta, int total) {
    setState(() {
      currentIndex = (currentIndex + delta).clamp(0, total - 1);
    });
  }

  void toggleLanguage() {
    setState(() {
      currentLanguage = (currentLanguage == 'en') ? 'ml' : 'en';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Milestones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: toggleLanguage,
          ),
        ],
      ),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, categoryState) {
          print(categoryState);
          if (categoryState is CategoryLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (categoryState is CategoryError) {
            return const Center(child: Text('An error occurred!4'));
          }
          if (categoryState is GetCategorySuccess) {
            final categories = categoryState.categories;
            if (currentCategory == null && categories.isNotEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                updateCategory(categories.first);
              });
            }

            return BlocBuilder<QuestionsCubit, QuestionsState>(
              builder: (context, questionState) {
                print(questionState);
                if (questionState is QuestionsLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (questionState is QuestionError) {
                  return const Center(child: Text('An error occurred1!'));
                }
                if (questionState is GetQuestionByCategorySuccess) {
                  final questions = questionState.questions;
                  if (questions.isEmpty) {
                    return const Center(child: Text('No Questions Available'));
                  }

                  return BlocListener<ChildCubit, ChildState>(
                    listener: (context, childLisState) {
                      if (childLisState is GetChildrenSuccess) {
                        setState(() {
                          childId = childLisState.defaultChild.id;
                        });
                      }
                    },
                    child: BlocBuilder<ChildCubit, ChildState>(
                      builder: (context, childState) {
                        print(childState);
                        if (childState is ChildLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        if (childState is ChildError) {
                          return const Center(
                            child: Text('An error occurred2'),
                          );
                        }
                        if (childState is GetChildrenSuccess) {
                          return BlocBuilder<
                            ChildResponseCubit,
                            ChildResponseState
                          >(
                            builder: (context, childResponseState) {
                              // if (childResponseState is ChildResponseError) {
                              //   return const Center(
                              //     child: Text('An error occurred1'),
                              //   );
                              // }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children:
                                            categories
                                                .map(
                                                  (category) =>
                                                      CategoryContainer(
                                                        label: category.name,
                                                        onTap:
                                                            () =>
                                                                updateCategory(
                                                                  category,
                                                                ),
                                                        color: Colors.red,
                                                      ),
                                                )
                                                .toList(),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            currentCategory?.name ??
                                                'No Category',
                                          ),
                                          Text(
                                            '${currentIndex + 1}/${questions.length}',
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    QuestionCard(
                                      question:
                                          currentLanguage == 'en'
                                              ? questions[currentIndex]
                                                  .questionEnglish
                                              : questions[currentIndex]
                                                  .questionMalayalam,
                                      font:
                                          currentLanguage == 'en'
                                              ? 'KleeOne'
                                              : 'NotoSansMalayalam',
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: Center(
                                        child: OptionsRow(
                                          onTapLeft:
                                              () => changeQuestionIndex(
                                                -1,
                                                questions.length,
                                              ),
                                          onTapRight:
                                              () => changeQuestionIndex(
                                                1,
                                                questions.length,
                                              ),
                                          onTapNo: () {
                                            context
                                                .read<ChildResponseCubit>()
                                                .addChildResponse(
                                                  questions[currentIndex].id,
                                                  false,
                                                  childState.defaultChild.id,
                                                );
                                            changeQuestionIndex(
                                              1,
                                              questions.length,
                                            );
                                          },
                                          onTapYes: () {
                                            context
                                                .read<ChildResponseCubit>()
                                                .addChildResponse(
                                                  questions[currentIndex].id,
                                                  true,
                                                  childState.defaultChild.id,
                                                );
                                            changeQuestionIndex(
                                              1,
                                              questions.length,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox(height: 10);
                      },
                    ),
                  );
                }
                return const Center(child: Text('No data available.'));
              },
            );
          }
          return const Center(child: Text('No categories available.'));
        },
      ),
    );
  }
}
