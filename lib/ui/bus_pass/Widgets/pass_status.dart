import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';

class PassStatus extends StatelessWidget {
  const PassStatus({Key? key, required this.data}) : super(key: key);
  final YourBus data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(25),
        Text('Pass Status'),
        CheckboxListTile(
          onChanged: (val) {},
          dense: true,
          contentPadding: EdgeInsets.zero,
          value: data.busPass!.isApproved,
          title: Text(
            'Pass Approved',
            style: TextStyle(fontSize: 18),
          ),
        ),
        CheckboxListTile(
          onChanged: (val) {},
          contentPadding: EdgeInsets.zero,
          dense: true,
          value: data.busPass!.isPaymentComplete,
          title: Text(
            'Payment Completed',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Divider(),
        Gap(10),
      ],
    );
  }
}
