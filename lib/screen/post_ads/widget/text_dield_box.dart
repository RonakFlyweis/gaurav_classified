import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

Widget textFieldBox(String name, var con) {
  return Container(
    width: double.infinity,
    height: 5.h,
    child: TextField(
      controller: con,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: name,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}

Widget textFieldBoxNum(String name, var con) {
  return Container(
    width: double.infinity,
    height: 5.h,
    child: TextField(
      controller: con,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: name,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}
