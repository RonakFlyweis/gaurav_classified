import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

Widget catItem(String name) {
  return Container(
    width: double.infinity,
    height: 8.h,
    padding: EdgeInsets.symmetric(horizontal: 15.sp),
    //color: Colors.red,
    child: Row(
      children: [
        // Image.asset(
        //   img,
        //   height: 6.h,
        // ),
        4.w.widthBox,
        name.text.size(16.sp).make(),
        Expanded(
            child: Container(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.arrow_forward_ios,
            size: 22.sp,
          ),
        ))
      ],
    ),
  );
}
