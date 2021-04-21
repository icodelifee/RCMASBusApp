import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/bus_pass/Widgets/pass_status.dart';
import 'package:rcmasbusapp/ui/bus_pass/Widgets/primary_details.dart';
import 'package:rcmasbusapp/ui/bus_pass/Widgets/route_stop_details.dart';
import 'package:rcmasbusapp/ui/components/app_bar.dart';
import 'package:rcmasbusapp/ui/components/snackbar.dart';
import 'package:rcmasbusapp/ui/home/home_page_viewmodel.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class BusPassPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final busPass = useProvider(yourBusProvider);
    return Scaffold(
        appBar: UAppBar(
          title: 'Bus Pass',
        ),
        body: busPass.when(
            data: (data) {
              final stop = data.route!.stops!.firstWhere(
                  (element) => element.stopId == data.busPass!.stopId!);
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your bus pass details',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      PrimaryDetails(
                        data: data,
                      ),
                      PassStatus(
                        data: data,
                      ),
                      RouteStopDetails(
                        stop: stop,
                        data: data,
                      )
                    ],
                  ),
                ),
              );
            },
            loading: () => CustomIndicator(),
            error: (err, stack) {
              showSnackbar(err.toString(), stack.toString());
              return SizedBox();
            }));
  }
}
