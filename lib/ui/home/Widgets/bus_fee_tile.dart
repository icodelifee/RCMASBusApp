import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../app_theme.dart';

class PayBusFeeTile extends StatelessWidget {
  const PayBusFeeTile({
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
        child: SizedBox(
          height: 80.0,
          width: 150.0,
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
                    'Pay',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF44B679)),
                  ),
                  Text('Bus Fee',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              Gap(16),
              Image.asset(
                'assets/pay-bus-fee.png',
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
