import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';

class HomePageListTile extends StatelessWidget {
  const HomePageListTile({
    required this.title,
    required this.image,
    required this.route,
    Key? key,
  }) : super(key: key);

  final String image;
  final String title;
  final Widget route;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 3),
      child: Card(
        elevation: 0.1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () => Get.to(() => route),
          borderRadius: circularBorder,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            padding: EdgeInsets.all(20),
            height: 80.0,
            width: 150.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(image),
                Gap(20),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
