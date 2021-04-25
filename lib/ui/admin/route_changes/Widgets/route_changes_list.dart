import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/change_route.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/ui/admin/route_changes/Widgets/approve_sheet.dart';
import 'package:rcmasbusapp/ui/admin/route_changes/route_changes_viewmodel.dart';
import 'package:rcmasbusapp/ui/admin/route_changes/view_route_change.dart';
import 'package:rcmasbusapp/utils/to_bold.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RouteChangesListView extends StatelessWidget {
  RouteChangesListView({required this.changeRoutes});
  final List<ChangeRoute> changeRoutes;
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemCount: changeRoutes.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: InkWell(
              onTap: () => Get.to(
                  () => ViewRouteChange(changeRoute: changeRoutes[index])),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Roll Number'.toBold(),
                    Text(changeRoutes[index].rollNumber!,
                        style: TextStyle(fontSize: 20)),
                    Gap(10),
                    statusText(index),
                    Gap(18),
                    'Status'.toBold(),
                    Text(changeRoutes[index].status!,
                        style: TextStyle(fontSize: 20)),
                    Gap(18),
                    changeRoutes[index].status == 'PENDING'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              approveButton(index),
                              cancelButton(context, index)
                            ],
                          )
                        : SizedBox()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Row statusText(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Approval Status'.toBold(),
            Text(changeRoutes[index].isApproved! ? 'Approved' : 'Not Approved',
                style: TextStyle(fontSize: 20)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Payment Status'.toBold(),
            Text(changeRoutes[index].paymentCompleted! ? 'Payed' : 'Not Payed',
                style: TextStyle(fontSize: 20)),
          ],
        ),
      ],
    );
  }

  TextButton approveButton(int index) {
    return TextButton(
        onPressed: () => Get.bottomSheet(RouteChangeApproveSheet(
              changeRoute: changeRoutes[index],
            )),
        style: buttonStyle,
        child: SizedBox(
          height: 30,
          width: Get.width / 3,
          child: Center(
            child: Text('APPROVE',
                style: TextStyle(fontSize: 17, color: Colors.white)),
          ),
        ));
  }

  TextButton cancelButton(BuildContext context, int index) {
    return TextButton(
        onPressed: () => _showCancelDialog(context, changeRoutes[index].docId!),
        style: buttonStyle.copyWith(
            backgroundColor: MaterialStateProperty.all(Colors.red)),
        child: SizedBox(
          height: 30,
          width: Get.width / 3,
          child: Center(
            child: Text('CANCEL',
                style: TextStyle(fontSize: 17, color: Colors.white)),
          ),
        ));
  }

  void _showCancelDialog(BuildContext context, String docId) async {
    await Get.dialog(AlertDialog(
      title: Text('Are you sure you want to cancel this request?'),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('NO')),
        TextButton(
            onPressed: () async {
              await context
                  .read(fireStoreRepositoryProvider)
                  .cancelBusRouteChange(docId);
              Get.back();
            },
            child: Text('YES'))
      ],
    ));
    await context.refresh(routeChangeListProvider);
  }
}
