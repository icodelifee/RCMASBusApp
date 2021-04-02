import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rcmasbusapp/app_theme.dart';

class YourProfileTile extends StatelessWidget {
  const YourProfileTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: cardShadow,
      margin: EdgeInsets.all(3.0),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF44B679)),
                ),
                Text('Profile',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            Gap(16),
            Image.asset(
              'assets/your-profile.png',
              height: 50,
              width: 50,
            )
          ],
        ),
      ),
    );
  }
}
