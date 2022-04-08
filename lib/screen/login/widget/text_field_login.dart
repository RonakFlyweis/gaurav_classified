import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

Widget textFieldEmail(String name, var cont) {
  return Container(
    width: 75.w,
    height: 5.h,
    child: TextField(
      controller: cont,
      decoration: InputDecoration(
        hintText: name,
        //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        suffixIcon: Icon(
          Icons.check_circle,
          color: Colors.grey,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}

Widget textFieldPassword(String name, var cont) {
  return Container(
    width: 75.w,
    height: 5.h,
    child: TextField(
      controller: cont,
      obscureText: true,
      decoration: InputDecoration(
        hintText: name,
        //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
        prefixIcon: Icon(
          Icons.lock_open,
          color: Colors.grey,
        ),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        suffixIcon: Icon(
          Icons.visibility_off,
          color: Colors.grey,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    ),
  );
}
