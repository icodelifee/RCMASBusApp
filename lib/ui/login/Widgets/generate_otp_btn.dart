import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/login/login_page_viewmodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GenerateOTPButton extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useState(false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: TextButton(
        onPressed: () async {
          state.value = true;
          Get.focusScope!.unfocus();
          final login = context.read(loginViewModelProvider);
          final isAdded = await login.checkUserEntry(login.phone!.text);
          if (isAdded) {
            await login.signIn(context);
          } else {
            showSnackbar('Your number has not been registered!',
                'Please contact the administator.');
          }
          state.value = false;
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          backgroundColor: MaterialStateProperty.all(Color(0xFF4CBD89)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: Center(
            child: state.value
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    'Generate OTP',
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
