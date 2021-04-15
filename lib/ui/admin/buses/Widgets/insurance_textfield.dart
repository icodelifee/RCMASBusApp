import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';
import 'package:rcmasbusapp/utils/date_formatter.dart';

class InsuranceTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busViewProvider);
    provider.insurance = useTextEditingController(
        text: provider.bus != null ? provider.bus!.insurance!.getDate() : null);
    provider.insuranceDate = provider.bus?.insurance;
    return TextFormField(
      readOnly: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please pick Insurance Renewal Date';
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
          provider.insuranceDate = date;
          provider.insurance!.text =
              DateFormat('d/MM/yyyy').format(date).toString();
        }
      },
      controller: provider.insurance,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Pick Insurance Renewal Date'),
    );
  }
}
