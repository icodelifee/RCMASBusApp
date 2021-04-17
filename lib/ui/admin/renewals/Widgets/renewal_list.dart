import 'package:flutter/material.dart';
import 'package:rcmasbusapp/data/model/renewal.dart';
import 'package:rcmasbusapp/ui/admin/renewals/Widgets/renewal_card.dart';

class RenewalsList extends StatelessWidget {
  RenewalsList({
    Key? key,
    required this.renewals,
    required this.approval,
  }) : super(key: key);
  final List<Renewal> renewals;
  final bool approval;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: renewals.length,
      itemBuilder: (BuildContext context, int index) {
        return RenewalsCard(renewals: renewals[index], approval: approval);
      },
    );
  }
}
