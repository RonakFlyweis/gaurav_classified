import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

Widget textFieldEdit(String name, var con) {
  return Container(
    width: 85.w,
    height: 5.h,
    child: TextField(
      controller: con,
      decoration: InputDecoration(
        hintText: name,
        //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),

        labelStyle: TextStyle(
          color: Colors.grey,
        ),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}

Widget textFieldEditPassword(String name, var con) {
  return Container(
    width: 85.w,
    height: 5.h,
    child: TextField(
      controller: con,
      obscureText: true,
      decoration: InputDecoration(
        hintText: name,
        //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),

        labelStyle: TextStyle(
          color: Colors.grey,
        ),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}
