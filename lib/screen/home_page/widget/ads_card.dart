import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/home_page/model/featured_model.dart';
import 'package:sn_2nd/screen/my_ads/model/myads_model.dart';
import 'package:sn_2nd/screen/tranding_ads/model/tranding_add_all_ads.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

Widget adsCard(AllAddmodel ad) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.sp),
    width: 35.w,
    height: 17.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 35.w,
          height: 10.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.sp),
            child: Image.network(
              ApiProvider.baseUrl + "/" + ad.image![0],
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(
                  'assets/image/health.png',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        .3.h.heightBox,
        Container(
          width: 35.w,
          child: ad.title!.text
              .size(10.sp)
              .bold
              .overflow(TextOverflow.ellipsis)
              .make(),
        ),
        .2.h.heightBox,
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 12.sp,
            ),
            Container(
              width: 15.h,
              child: ad.location!.text
                  .size(8.sp)
                  .overflow(TextOverflow.ellipsis)
                  .make(),
            ),
          ],
        ),
        .2.h.heightBox,
        ' ₹  ${ad.price}'.text.size(10.sp).color(Colors.blue).make(),
      ],
    ),
  );
}

Widget myAdsCard(MyAdsModel ad) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 5.sp),
    width: 35.w,
    height: 17.h,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 35.w,
          height: 10.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.sp),
            child: Image.network(
              ApiProvider.baseUrl + "/" + ad.image![0],
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(
                  'assets/image/health.png',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        .3.h.heightBox,
        Container(
          width: 35.w,
          child: ad.title!.text
              .size(10.sp)
              .bold
              .overflow(TextOverflow.ellipsis)
              .make(),
        ),
        .2.h.heightBox,
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 12.sp,
            ),
            Container(
              width: 15.h,
              child: ad.location!.text
                  .size(8.sp)
                  .overflow(TextOverflow.ellipsis)
                  .make(),
            ),
          ],
        ),
        .2.h.heightBox,
        ' ₹  ${ad.price}'.text.size(10.sp).color(Colors.blue).make(),
      ],
    ),
  );
}
