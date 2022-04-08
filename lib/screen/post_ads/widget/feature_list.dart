import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

Widget featureList(String name, bool val) {
  return Row(
    children: [
      Container(
        height: 3.h,
        width: 6.w,
        decoration: BoxDecoration(
            color: val ? Colors.blue : Colors.white,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(5.sp)),
      ),
      4.w.widthBox,
      name.text.size(16.sp).make(),
    ],
  ).pOnly(bottom: 5.sp);
}
