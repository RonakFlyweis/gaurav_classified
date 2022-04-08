import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

Widget textFieldSetting(String name, var con) {
  return Container(
    width: double.infinity,
    height: 5.h,
    child: TextField(
      controller: con,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: name,
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

Widget textFieldSettingPass(String name, var con) {
  return Container(
    width: double.infinity,
    height: 5.h,
    child: TextField(
      controller: con,
      obscureText: true,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: name,
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
