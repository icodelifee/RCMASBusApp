import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoteBox extends StatelessWidget {
  const NoteBox(
      {Key? key, required this.title, required this.step, required this.note})
      : super(key: key);

  final String title;
  final String step;
  final String note;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width,
      height: 90,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xFFC6DFB4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          Text('Step $step of 3',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18)),
          Text('Note: $note',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14))
        ],
      ),
    );
  }
}
