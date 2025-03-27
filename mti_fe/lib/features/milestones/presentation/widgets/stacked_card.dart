import 'package:flutter/material.dart';

class StackedCard extends StatelessWidget {
  final double left;
  final double right;
  final double top;

  const StackedCard({
    super.key, 
    required this.left, 
    required this.right,
    required this.top,
  });


  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.8),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
