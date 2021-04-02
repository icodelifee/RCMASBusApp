import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rcmasbusapp/app_theme.dart';

class BusPassTile extends StatelessWidget {
  const BusPassTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      decoration: cardShadow,
      margin: EdgeInsets.all(3.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        child: SizedBox(
          height: 80.0,
          width: 150.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Bus',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF44B679)),
              ),
              Gap(4),
              Text('Pass',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Gap(7),
              Image.asset(
                'assets/bus-pass.png',
                height: 50,
                width: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
