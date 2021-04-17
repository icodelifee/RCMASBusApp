import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/ui/admin/renewals/renewals_viewmodel.dart';
import 'package:search_page/search_page.dart';
import 'Widgets/approved_renewals.dart';
import 'Widgets/not_approved_renewals.dart';
import 'Widgets/renewal_card.dart';

class RenewalsPage extends HookWidget {
  RenewalsPage({Key? key}) : super(key: key);
  final pages = [
    ApprovedRenewals(),
    NotApprovedRenewals(),
  ];
  @override
  Widget build(BuildContext context) {
    final provider = useProvider(renewalsProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Renewals List'),
            backgroundColor: Colors.white,
            bottom: TabBar(
              indicatorColor: AppColors.secondaryColor,
              tabs: [
                Tab(
                  icon: Icon(Icons.approval),
                  text: 'Approved',
                ),
                Tab(
                  icon: Icon(Icons.highlight_off_rounded),
                  text: 'Not Approved',
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Search people',
            onPressed: provider.data == null
                ? null
                : () => showSearch(
                      context: context,
                      delegate: SearchPage<Renewal>(
                        items: provider.data!.value,
                        searchLabel: 'Search renewals',
                        suggestion: Center(
                          child: Text(
                              'Filter renewals by roll number, first name, course'),
                        ),
                        failure: Center(
                          child: Text('No renewals found :('),
                        ),
                        filter: (renewal) => [
                          renewal.rollNo,
                          renewal.student!.firstName,
                          renewal.student!.course,
                        ],
                        builder: (renewal) => RenewalsCard(
                          approval: renewal.isApproved!,
                          renewals: renewal,
                        ),
                      ),
                    ),
            child: Icon(Icons.search),
          ),
          body: TabBarView(
            children: pages,
          )),
    );
  }
}
