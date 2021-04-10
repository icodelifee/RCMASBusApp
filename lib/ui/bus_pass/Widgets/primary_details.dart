import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/data/model/your_bus.dart';

class PrimaryDetails extends StatelessWidget {
  const PrimaryDetails({Key? key, required this.data}) : super(key: key);
  final YourBus data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(15),
        SizedBox(
          width: Get.width / 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('First Name'),
                  Text(
                    data.busPass!.student!.firstName!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Last Name'),
                  Text(
                    data.busPass!.student!.lastName!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            ],
          ),
        ),
        Gap(20),
        Text(
          'Roll number',
        ),
        Text(
          data.busPass!.student!.rollNumber!,
          style: TextStyle(fontSize: 20),
        ),
        Gap(20),
        SizedBox(
          width: Get.width / 1.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bus Number'),
                  Text(
                    data.bus!.busNo!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bus License No'),
                  Text(
                    data.bus!.busLicenseNo!,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
