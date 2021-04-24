import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rcmasbusapp/ui/admin/admin_common/appbar.dart';

class RouteChangesPage extends HookWidget {
  const RouteChangesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AdminAppBar(title: 'Route Changes List'), body: Container());
  }
}
