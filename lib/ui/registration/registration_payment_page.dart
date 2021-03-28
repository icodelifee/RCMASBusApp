import 'package:flutter/material.dart';
import 'package:rcmasbusapp/ui/components/vertical_spacer.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/notes_box.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/payment_code_field.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/payment_submit_btn.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/registration_appbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class RegistrationPaymentPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RegistrationAppBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NoteBox(
                  title: 'Bus Fee Payment',
                  step: '3',
                  note: 'Please enter the payment code correctly.'),
              VerticalSpacer(num: 30),
              TextFieldLabel(label: 'Payment Code'),
              PaymentCodeField(),
              Spacer(),
              PaymentSubmitButton(formKey: formKey),
            ],
          ),
        ),
      ),
    );
  }
}
