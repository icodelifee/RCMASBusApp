import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/ui/admin/renewals/renewals_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/error_text.dart';
import 'package:rcmasbusapp/ui/components/no_data.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';
import 'package:rcmasbusapp/ui/admin/renewals/Widgets/renewal_list.dart';

class NotApprovedRenewals extends HookWidget {
  const NotApprovedRenewals({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final renewalProvider = useProvider(renewalsProvider);
    return Container(
      padding: EdgeInsets.all(10),
      child: renewalProvider.when(
          data: (List<Renewal> renewals) {
            renewals =
                renewals.where((element) => !element.isApproved!).toList();
            if (renewals.isNotEmpty) {
              return RenewalsList(
                renewals: renewals,
                approval: false,
              );
            } else {
              return NoData();
            }
          },
          loading: () => CustomIndicator(),
          error: (err, stack) {
            return ErrorText();
          }),
    );
  }
}
