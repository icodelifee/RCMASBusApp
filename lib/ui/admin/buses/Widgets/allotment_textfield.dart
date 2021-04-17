import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/text_field_label.dart';

class AllotmentTextField extends HookWidget {
  const AllotmentTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busViewProvider);
    provider.allotedSeats = useTextEditingController(
        text: provider.bus != null
            ? provider.bus!.allottedSeats.toString()
            : null);
    provider.totalSeats = useTextEditingController(
        text:
            provider.bus != null ? provider.bus!.totalSeats.toString() : null);
    print(provider.bus!.totalSeats);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldLabel(label: 'Total Seats *'),
            Gap(7),
            SizedBox(
              width: Get.width / 2.4,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter total seats';
                  }
                  return null;
                },
                controller: provider.totalSeats,
                decoration: InputDecoration(
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    filled: true,
                    fillColor: AppColors.textInputFillColor,
                    hintText: 'Total Seats'),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldLabel(label: 'Allotted Seats *'),
            Gap(7),
            SizedBox(
              width: Get.width / 2.4,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter allotted seats';
                  }
                  return null;
                },
                controller: provider.allotedSeats,
                decoration: InputDecoration(
                    border: border,
                    focusedBorder: border,
                    enabledBorder: border,
                    filled: true,
                    fillColor: AppColors.textInputFillColor,
                    hintText: 'Alloted Seats'),
              ),
            ),
          ],
        )
      ],
    );
  }
}
