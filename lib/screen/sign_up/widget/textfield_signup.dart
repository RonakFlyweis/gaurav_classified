import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

Widget textFieldSignup(String name, IconData icon, var cont) {
  return Container(
    width: 70.w,
    height: 5.h,
    child: TextField(
      controller: cont,
      decoration: InputDecoration(
        hintText: name,
        //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
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

Widget textFieldMobSignup(String name, IconData icon, var cont) {
  return Container(
    width: 70.w,
    height: 5.h,
    child: TextField(
      controller: cont,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: name,
        //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
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

Widget textFieldPassSignup(String name, IconData icon, var cont) {
  return Container(
    width: 70.w,
    height: 5.h,
    child: TextField(
      controller: cont,
      obscureText: true,
      decoration: InputDecoration(
        hintText: name,
        //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
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
