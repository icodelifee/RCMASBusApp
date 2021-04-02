import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcmasbusapp/app_theme.dart';

class InformationCard extends StatelessWidget {
  const InformationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 9, right: 9),
      decoration: cardShadow,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(20),
          width: Get.size.width,
          // height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Divider(),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ut eu tellus molestie tellus adipiscing adipiscing. Nec maecenas enim est vulputate.',
                style: TextStyle(
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.normal,
                    fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
