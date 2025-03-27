import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {

  final String label;
  final Color color;
  final VoidCallback onTap;


  const CategoryContainer({super.key, required this.label, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Text( label, 
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
            ),
          ),
        ),
      ),
    );
  }
}