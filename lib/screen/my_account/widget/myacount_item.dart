import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

Widget myaccountItem(var img, String name) {
  return Container(
    width: double.infinity,
    height: 7.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              img,
              size: 30.sp,
            ),
            6.w.widthBox,
            name.text.size(18.sp).make(),
          ],
        ),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
