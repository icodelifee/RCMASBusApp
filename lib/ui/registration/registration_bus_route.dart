import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:rcmasbusapp/data/model/login_user.dart';
import 'package:rcmasbusapp/ui/components/vertical_spacer.dart';
import 'package:rcmasbusapp/ui/login/Widgets/route_selector.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/notes_box.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/registration_appbar.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/stop_selector.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/submit_btn.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class RegistrationBusRoute extends HookWidget {
  RegistrationBusRoute({required LoginUser user}) : _user = user;
  final LoginUser _user;
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
                  title: 'Bus Route Selection',
                  step: '2',
                  note: 'Please select your route and stop correctly'),
              VerticalSpacer(num: 30),
              TextFieldLabel(label: '*Bus Route'),
              RouteSelector(),
              Gap(15),
              StopSelector(),
              Spacer(),
              SubmitButton(formKey: formKey, user: _user)
            ],
          ),
        ),
      ),
    );
  }
}
