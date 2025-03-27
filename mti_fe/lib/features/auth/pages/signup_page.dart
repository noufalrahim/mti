import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:milestone_tracker_of_infants/features/auth/cubit/auth_cubit.dart';
import 'package:milestone_tracker_of_infants/features/auth/presentation/widgets/otp_bottom_modal_sheet.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/icon_container.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_button.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void signUpUser() {
    Navigator.pop(context);
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(phone: phoneController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.chevron_left, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) async {
            if (state is AuthError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error.toString())));
            } else if (state is AuthSignUp) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Successfully logged in')));
              
              final prefs = await SharedPreferences.getInstance();
              String? jsonString = prefs.getString('loggedInUser');
              var loggedInUser;
              if (jsonString != null) {
                print("here1");
                loggedInUser = jsonDecode(jsonString);
                print(loggedInUser);
                if(loggedInUser['defaultChild'] != null) {
                  print("here2");
                  context.go('/', extra: loggedInUser['id']);
                }
                else {
                  print("here3");
                  context.go('/details', extra: loggedInUser['id']);
                }
              }
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Aligns content to top
                children: [
                  const IconContainer(),
                  const SizedBox(height: 20),
                  const SizedBox(
                    width: 300,
                    child: Text(
                      "Track Your Baby's Milestones And Celebrate Each Moment – Parenthood Is A Journey For Both Of You.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Expanded(
                    child: Material(
                      elevation: 5, // Top elevation
                      shadowColor: Colors.black26, // Optional shadow color
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16), // Adds inner spacing
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Create an account',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Enter your mobile number',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Form(
                                    key: formKey,
                                    child: PrimaryInput(
                                      label: "",
                                      controller: phoneController,
                                      hintText: "Enter Your Mobile Number",
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty ||
                                            value.length != 10) {
                                          return "Field is invalid";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  PrimaryButton(
                                    label: 'Continue',
                                    onTap: () {
                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return OtpBottomModalSheet(onComplete: signUpUser,);
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Theme.of(
                                          context,
                                        ).textTheme.bodyMedium?.color,
                                  ), // Default text style
                                  children: [
                                    const TextSpan(
                                      text:
                                          ' By clicking Continue, you agree to our ',
                                    ),
                                    TextSpan(
                                      text: 'Terms of Service',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary, // Highlighted color
                                      ),
                                    ),
                                    const TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Privacy Policy',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context)
                                                .colorScheme
                                                .secondary, // Highlighted color
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
