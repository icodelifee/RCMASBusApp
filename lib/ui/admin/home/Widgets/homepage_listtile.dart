import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';

class HomePageListTile extends StatelessWidget {
  const HomePageListTile({
    required this.title1,
    required this.title2,
    required this.route,
    Key? key,
  }) : super(key: key);

  final String title1;
  final String title2;
  final Widget route;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => Get.to(() => route),
        borderRadius: circularBorder,
        child: Container(
          padding: EdgeInsets.all(20),
          height: 80.0,
          width: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title1,
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF44B679)),
              ),
              Gap(6),
              Text(title2,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
