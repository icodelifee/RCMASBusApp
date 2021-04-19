import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/ui/admin/buspass/Widgets/card_data.dart';
import 'package:rcmasbusapp/ui/admin/buspass/approved_buspass_page.dart';
import 'package:rcmasbusapp/ui/admin/buspass/unapproved_buspass_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:search_page/search_page.dart';

class BusPassPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final passes = await context
                  .read(fireStoreRepositoryProvider)
                  .getAllBusPass();
              await showSearch(
                  context: context,
                  delegate: SearchPage<BusPass>(
                      items: passes,
                      searchLabel: 'Search buspass',
                      suggestion: Center(
                        child: Text('Filter buspass by roll number'),
                      ),
                      failure: Center(
                        child: Text('No pass found :('),
                      ),
                      filter: (pass) => [pass.rollNo],
                      builder: (pass) => Card(child: CardData(buspass: pass))));
            },
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Bus Passes'),
            bottom: TabBar(
              indicatorColor: AppColors.secondaryColor,
              labelColor: Colors.black,
              tabs: [
                Tab(
                  icon: Icon(Icons.approval),
                  text: 'Approved',
                ),
                Tab(
                  icon: Icon(Icons.not_interested_sharp),
                  text: 'Unapproved',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [ApprovedBusPassPage(), UnApprovedBusPassPage()],
          )),
    );
  }
}
