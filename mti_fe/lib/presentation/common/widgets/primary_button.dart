import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  const PrimaryButton({super.key, required this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF62CDFA), // Move background color to Material
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10), // Ensures ripple follows shape
        splashColor: Colors.white.withOpacity(0.3), // Custom ripple color
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
