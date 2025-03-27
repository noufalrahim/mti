import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:milestone_tracker_of_infants/features/home/cubit/child_cubit.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/icon_container.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_button.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_input.dart';

class DetailsPage extends StatefulWidget {
  final int userId;

  const DetailsPage({super.key, required this.userId});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String selectedGender = "Girl";
  bool isPremature = false;
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weeksPrematureController =
      TextEditingController();

  @override
  void dispose() {
    _dobController.dispose();
    _nameController.dispose();
    _weeksPrematureController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dobController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
      });
    }
  }

  void _printDetails() async {
    print("Name: ${_nameController.text}");
    print("Date of Birth: ${_dobController.text}");
    print("Gender: $selectedGender");
    print("Premature: $isPremature");
    if (isPremature) {
      print("Weeks Premature: ${_weeksPrematureController.text}}");
    }

    await context.read<ChildCubit>().createNewChild(
      name: _nameController.text,
      dob: _dobController.text,
      isPremature: isPremature,
      weeksOfPremature: _weeksPrematureController.text,
      userId: widget.userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChildCubit, ChildState>(
      listener: (context, state) {
        if (state is ChildError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        } else if (state is AddNewChildSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Task Added Successfully')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {},
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
                  const Center(child: IconContainer()),
                  const SizedBox(height: 10),
                  PrimaryInput(
                    label: 'Name',
                    hintText: 'John',
                    controller: _nameController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _dobController,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      hintText: 'MM/DD/YYYY',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Gender',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  _buildRadioTile("Girl"),
                  _buildRadioTile("Boy"),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: isPremature,
                        onChanged:
                            (value) => setState(() => isPremature = value!),
                      ),
                      const Expanded(
                        child: Text(
                          "Was your baby born prematurely?",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  if (isPremature) ...[
                    const SizedBox(height: 20),
                    PrimaryInput(
                      label: 'No. of weeks of premature',
                      hintText: '3',
                      controller: _weeksPrematureController,
                    ),
                  ],
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: 'Continue',
                    onTap: () {
                      _printDetails();
                      print("USERI....${widget.userId}");
                      context.go('/', extra: widget.userId);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRadioTile(String value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(value),
      leading: Radio<String>(
        value: value,
        groupValue: selectedGender,
        onChanged: (newValue) => setState(() => selectedGender = newValue!),
      ),
    );
  }
}
