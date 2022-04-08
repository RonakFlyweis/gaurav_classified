import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

Widget dropDownBox(String name) {
  return Container(
    width: double.infinity,
    height: 6.h,
    decoration: BoxDecoration(
      //color: Colors.red,
      border: Border(
        bottom: BorderSide(width: 2, color: Colors.grey.shade400),
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        name.text.size(14.sp).gray400.make(),
        Icon(
          Icons.arrow_drop_down,
          size: 30.sp,
        ),
      ],
    ),
  );
}
