import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Layout extends StatelessWidget {
  const Layout(this.widgets);

  final List<Widget> widgets;

  @override
  Widget build(BuildContext context) => Container(
        width: Get.width,
        height: Get.height * .1,
        decoration: BoxDecoration(
            color: Color(0xfff5faff), borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          ),
        ),
      );
}
