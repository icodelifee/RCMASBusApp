import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/card_data.dart';
import 'package:rcmasbusapp/ui/admin/buspass/buspass_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/no_data.dart';

class ApprovedBusPassPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(busPassViewProvider);
    final busPassesFuture = useFuture(
        useMemoized(() => provider.getAllBusPass()),
        initialData: null);

    if (busPassesFuture.hasData) {
      final buspasses = busPassesFuture.data!
          .where((element) => element.isApproved!)
          .toList();
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(
          thickness: 1.0,
        ),
        itemCount: buspasses.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Approve',
                closeOnTap: true,
                foregroundColor: Colors.black,
                color: AppColors.secondaryColor,
                iconWidget: Icon(Icons.approval),
                onTap: () {},
              ),
            ],
            child: CardData(buspass: buspasses[index]),
          );
        },
      );
    } else {
      return NoData();
    }
  }
}
