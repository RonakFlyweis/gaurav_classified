import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/home_page/model/featured_model.dart';
import 'package:sn_2nd/screen/tranding_ads/model/tranding_add_all_ads.dart';
import 'package:velocity_x/velocity_x.dart';

Widget favCard(AllAddmodel ads) {
  return Container(
    height: 15.h,
    width: double.infinity,
    //color: Colors.red,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 40.w,
          height: 14.h,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.sp),
                  child: Image.asset(
                    'assets/image/health.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 2.w,
                top: 1.h,
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 25.sp,
                ),
              ),
            ],
          ),
        ),
        3.w.widthBox,
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46.w,
              child: ads.title!.text
                  .size(12.sp)
                  .bold
                  .overflow(TextOverflow.ellipsis)
                  .make(),
            ),
            1.h.heightBox,
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 12.sp,
                ),
                Container(
                  width: 42.w,
                  child: ads.location!.text
                      .size(8.sp)
                      .overflow(TextOverflow.ellipsis)
                      .make(),
                ),
              ],
            ),
            .5.h.heightBox,
            ' \$ ${ads.price}'.text.size(12.sp).color(Colors.blue).make(),
            .5.h.heightBox,
            Row(
              children: [
                Icon(
                  Icons.watch_later_outlined,
                  size: 14.sp,
                ),
                3.w.widthBox,
                Container(
                  width: 36.w,
                  child: '5 hours ago'
                      .text
                      .size(8.sp)
                      .overflow(TextOverflow.ellipsis)
                      .make(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
