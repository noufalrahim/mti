import 'package:flutter/material.dart';
import 'package:milestone_tracker_of_infants/features/auth/presentation/widgets/otp_input.dart';
import 'package:milestone_tracker_of_infants/presentation/common/widgets/primary_button.dart';

class OtpBottomModalSheet extends StatelessWidget {

  final VoidCallback onComplete;

  const OtpBottomModalSheet({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: double.infinity,
              child: const Text(
                "Enter OTP",
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            OTPInput(
              onCompleted: (otp) {
                onComplete();
              },
            ),
            const SizedBox(height: 20),
            PrimaryButton(onTap: onComplete, label: 'Verify'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text('Resend OTP', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
