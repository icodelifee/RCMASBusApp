import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/registration/registration_bus_route.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';
import '../../../app_theme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NextButton extends StatelessWidget {
  NextButton({required LoginUser user}) : _user = user;
  final LoginUser _user;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final provider = context.read(registrationPageViewModelProvider);
        if (provider.formKey.currentState!.validate()) {
          Get.to(() => RegistrationBusRoute(user: _user));
        } else {
          showSnackbar('Please fill all the fields',
              'All Fields must be filled to procced');
        }
      },
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        backgroundColor: MaterialStateProperty.all(AppColors.buttonColor),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
