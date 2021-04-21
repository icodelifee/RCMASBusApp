import 'package:flutter/material.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SubmitOTPBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: ElevatedButton(
        onPressed: () async {
          await context.read(loginViewModelProvider).submitOTP();
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            backgroundColor: MaterialStateProperty.all(
              Color(0xFF4CBD89),
            )),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: Text(
              'Submit OTP',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
    );
  }
}
