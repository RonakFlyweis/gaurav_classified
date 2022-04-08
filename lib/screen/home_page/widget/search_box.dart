import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

Widget searchBox() {
  return Container(
    width: 90.w,
    height: 6.h,
    padding: EdgeInsets.all(3.sp),
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: Colors.grey),
      borderRadius: BorderRadius.circular(15.sp),
    ),
    child: TextField(
      style: TextStyle(fontSize: 14.sp, color: Colors.grey),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          size: 30.sp,
          color: Colors.grey,
        ),
        border: InputBorder.none,
        hintText: 'Where do you want to go?',
        contentPadding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 10.sp),
      ),
    ),
  );
}
