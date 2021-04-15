import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buses/buses_viewmodel.dart';
import 'package:rcmasbusapp/utils/date_formatter.dart';

class TaxTextField extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busViewProvider);
    provider.tax = useTextEditingController(
        text: provider.bus != null ? provider.bus!.tax!.getDate() : null);
    provider.taxDate = provider.bus?.tax;
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please pick Tax Renewal Date';
        }
        return null;
      },
      readOnly: true,
      onTap: () async {
        final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2017),
            lastDate: DateTime(DateTime.now().year + 6));
        if (date != null) {
          provider.taxDate = date;
          provider.tax!.text = DateFormat('d/MM/yyyy').format(date).toString();
        }
      },
      controller: provider.tax,
      decoration: InputDecoration(
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          filled: true,
          fillColor: AppColors.textInputFillColor,
          hintText: 'Pick Tax Renewal Date'),
    );
  }
}
