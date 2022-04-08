import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:velocity_x/velocity_x.dart';

Widget profileList(String text, var icon) {
  return Row(
    children: [
      Icon(
        icon,
        size: 18.sp,
      ),
      5.w.widthBox,
      text.text.size(12.sp).gray500.make(),
    ],
  );
}
