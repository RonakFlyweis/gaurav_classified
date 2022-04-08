import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

Widget drawerItem(String img, String name) {
  return Container(
    width: double.infinity,
    height: 8.h,
    padding: EdgeInsets.symmetric(horizontal: 15.sp),
    //color: Colors.red,
    child: Row(
      children: [
        Image.asset(
          img,
        ),
        4.w.widthBox,
        name.text.size(20.sp).make(),
      ],
    ),
  );
}
