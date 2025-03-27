import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      elevation: 5,
      shape: CircleBorder(), // Ensures a circular shape
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(100)),
        child: SizedBox(
          width: 125,
          height: 125,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: Center(
              child: Icon(
                Icons.child_care_outlined,
                size: 100,
                color: Color.fromARGB(255, 213, 228, 255),
              ),
            ),
          ),
        ),
      ),
    );
  }
}