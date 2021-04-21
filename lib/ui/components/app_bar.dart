import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UAppBar extends StatelessWidget implements PreferredSizeWidget {
  UAppBar({Key? key, required this.title})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);
  @override
  final Size preferredSize;
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: Get.theme!.iconTheme,
      title: Text(
        title,
        style: Get.textTheme!.headline6,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
