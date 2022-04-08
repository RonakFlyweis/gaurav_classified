import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/description_page/add_description.dart';
import 'package:sn_2nd/screen/favorite_ads/widget/fav_card.dart';
import 'package:sn_2nd/screen/home_page/model/featured_model.dart';
import 'package:sn_2nd/screen/tranding_ads/model/tranding_add_all_ads.dart';
import 'package:sn_2nd/web_services/api_provider.dart';

import 'package:velocity_x/velocity_x.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<FeaturedAd> favAds = [];
  List<AllAddmodel> allAddmodel = [];
  // dynamic favAdsData;
  // @override
  // void initState() {
  //   super.initState();
  //   _getApi();
  // }

  // _getApi() async {
  //   EasyLoading.show(status: 'Loading...', dismissOnTap: false);
  //   Response r = await ApiProvider.getFavoriteAds();
  //   EasyLoading.dismiss();
  //   print("here getting all fav ads");
  //   print(r.body);
  //   print('----------------------------');
  //   if (r.statusCode == 201) {
  //     //allAddmodel = allAddmodelFromJson(r.body);
  //     favAdsData = jsonDecode(r.body);
  //     print(favAdsData);
  //   }
  //   print(allAddmodel.length);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
          //color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              1.h.heightBox,
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_outlined,
                    size: 25.sp,
                  ).onTap(() {
                    Navigator.pop(context);
                  }),
                  2.w.widthBox,
                  'Favorite Ads'.text.bold.size(20.sp).letterSpacing(1).make(),
                ],
              ),
              2.h.heightBox,
              Expanded(
                  child: FutureBuilder(
                future: ApiProvider.getFavoriteAds(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
// itemCount: allAddmodel.length,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        final data = snapshot.data[i];
                        print('daTA');
                        print(data);
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
                                  border:
                                      Border.all(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
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
                                    child: data['title'].toString()
                                        .text
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
                                        child: data['location'].toString()
                                            .text
                                            .size(8.sp)
                                            .overflow(TextOverflow.ellipsis)
                                            .make(),
                                      ),
                                    ],
                                  ),
                                  .5.h.heightBox,
                                  '₹ ${data['price'].toString()}'
                                      .text
                                      .size(12.sp)
                                      .color(Colors.blue)
                                      .make(),
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
// return favCard(allAddmodel[i]).onTap(() {
//   Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => AdsDescription(
//                 data: allAddmodel[i],
//               )));
// });
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return Center(
                        child: SizedBox(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator()));
                  }
                  return Container();
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
