import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';
import 'package:rcmasbusapp/utils/date_formatter.dart';

class PollutionTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busViewProvider);
    provider.pollution = useTextEditingController(
        text: provider.bus != null ? provider.bus!.pollution!.getDate() : null);
    provider.pollutionDate = provider.bus?.pollution;
    return TextFormField(
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please pick Pollution Renewal Date';
        }
        return null;
      },
      onTap: () async {
        final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2017),
            lastDate: DateTime(DateTime.now().year + 6));
        if (date != null) {
          provider.pollutionDate = date;
          provider.pollution!.text =
              DateFormat('d/MM/yyyy').format(date).toString();
        }
      },
      controller: provider.pollution,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Pick Pollution Renewal Date'),
    );
  }
}
