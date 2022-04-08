import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

Widget catBox(String img, String name) {
  return Container(
    width: 20.w,
    height: 10.h,
    //color: Colors.black,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.network(
          img,
          height: 6.h,
          width: 20.w,
          errorBuilder:
              (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Container(
              height: 6.h,
              width: 20.w,
              color: Vx.amber100,
              child: Center(child: Text('😢')),
            );
          },
        ),
        name.text.size(8.sp).align(TextAlign.center).make(),
      ],
    ),
  );
}
