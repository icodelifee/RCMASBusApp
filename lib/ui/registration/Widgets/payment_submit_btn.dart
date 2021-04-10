import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/home/home_page.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';

import '../../../app_theme.dart';

class PaymentSubmitButton extends HookWidget {
  const PaymentSubmitButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(registrationPageViewModelProvider);
    return TextButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          await provider.completePayment();
          await Get.offAll(() => HomePage());
        } else {
          showSnackbar('Please fill all the fields',
              'All Fields must be filled to procced');
        }
      },
      style: btnStyle(),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: !provider.isLoading
            ? btnText()
            : Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white))),
      ),
    );
  }

  ButtonStyle btnStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      backgroundColor: MaterialStateProperty.all(AppColors.buttonColor),
    );
  }

  Row btnText() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Submit',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w900),
        ),
        Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
        )
      ],
    );
  }
}
