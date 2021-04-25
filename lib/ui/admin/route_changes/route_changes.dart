import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';
import 'package:rcmasbusapp/ui/admin/route_changes/Widgets/route_changes_list.dart';
import 'package:rcmasbusapp/ui/admin/route_changes/route_changes_viewmodel.dart';
import 'package:rcmasbusapp/ui/components/error_text.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class RouteChangesPage extends HookWidget {
  const RouteChangesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeChanges = useProvider(routeChangeListProvider);
    return Scaffold(
        appBar: AdminAppBar(title: 'Route Changes List'),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: routeChanges.when(
              data: (data) => RouteChangesListView(
                    changeRoutes: data,
                  ),
              loading: () => CustomIndicator(),
              error: (_, __) => ErrorText()),
        ));
  }
}
