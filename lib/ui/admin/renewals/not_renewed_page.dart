import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/card_data.dart';
import 'package:rcmasbusapp/ui/admin/renewals/renewals_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/error_text.dart';
import 'package:rcmasbusapp/ui/components/no_data.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class NotRenewed extends HookWidget {
  const NotRenewed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(notRenewedBusPassProvider);
    return Scaffold(
      appBar: AdminAppBar(
        title: 'Not Renewed',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: provider.when(
            data: (data) {
              if (data.isNotEmpty) {
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(child: CardData(buspass: data[index]));
                    });
              } else {
                return NoData();
              }
            },
            loading: () => CustomIndicator(),
            error: (err, stack) => ErrorText()),
      ),
    );
  }
}
