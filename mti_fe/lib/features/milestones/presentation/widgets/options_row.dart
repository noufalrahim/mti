import 'package:flutter/material.dart';

class OptionsRow extends StatelessWidget {

  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;
  final VoidCallback onTapYes;
  final VoidCallback onTapNo;

  const OptionsRow({super.key, required this.onTapLeft, required this.onTapRight, required this.onTapNo, required this.onTapYes});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(onPressed: onTapLeft, icon: Icon(Icons.chevron_left, size: 35)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildChoiceButton('Yes 👍', onTapYes),
            SizedBox(width: 20),
            _buildChoiceButton('No 👎', onTapNo),
          ],
        ),
        IconButton(onPressed: onTapRight, icon: Icon(Icons.chevron_right, size: 35)),
      ],
    );
  }

  Widget _buildChoiceButton(String choice, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          borderRadius: BorderRadius.circular(10), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Shadow color
              spreadRadius: 2, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(3, 3), // Shadow position (X, Y)
            ),
          ],
        ),
        child: Text(
          // 'No 👎',
          choice,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
    );
  }
}
