import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/home_page/model/featured_model.dart';
import 'package:sn_2nd/screen/profile/model/profile_model.dart';
import 'package:sn_2nd/screen/profile/widget/profile_ads.dart';
import 'package:sn_2nd/screen/profile/widget/profile_bar.dart';
import 'package:sn_2nd/screen/profile/widget/profile_list.dart';
import 'package:sn_2nd/web_services/api_provider.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:sn_2nd/screen/nav_page/home.dart';

import '../description_page/add_description.dart';
import '../home_page/widget/ads_card.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key? key,
    required this.pData,
  }) : super(key: key);
  ProfileModel pData = ProfileModel();
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;

  getFeaturedAds() async {
    Response r = await ApiProvider.getAllAds();
    if (r.statusCode >= 200 && r.statusCode <= 210) {
      return jsonDecode(r.body);
    } else {
      return [];
    }
  }
  List<FeaturedAd> pubAds = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(height: 28.h, child: profileBar(context, widget.pData)),
            Container(
              width: double.infinity,
              //  color: Colors.amber,
              padding: EdgeInsets.only(left: 20.sp, top: 25.sp, right: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileList(widget.pData.phone ?? '', Icons.phone),
                  2.h.heightBox,
                  profileList(widget.pData.email ?? '', Icons.email),
                  (1.5).h.heightBox,
                  'Published Ads'.text.size(16.sp).bold.make(),
                  (1.5).h.heightBox,
                  // FutureBuilder(
                  //   future: getFeaturedAds(),
                  //   builder: (BuildContext context,
                  //       AsyncSnapshot<dynamic> snapshot) {
                  //     if (snapshot.connectionState ==
                  //             ConnectionState.done &&
                  //         snapshot.hasData) {
                  //       print('here in');
                  //       final featuredAds = snapshot.data;
                  //       return ListView.builder(
                  //           itemCount: featuredAds.length,
                  //           //featuredAds.length,
                  //           scrollDirection: Axis.vertical,
                  //           shrinkWrap: true,
                  //           physics: BouncingScrollPhysics(),
                  //           itemBuilder: (context, index) {
                  //             final item = featuredAds[index];
                  //             return Container(
                  //               color: Colors.black,
                  //               height: 15.h,
                  //               width: double.infinity,
                  //               //color: Colors.red,
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                     MainAxisAlignment.start,
                  //                 crossAxisAlignment:
                  //                     CrossAxisAlignment.center,
                  //                 children: [
                  //                   Container(
                  //                     width: 40.w,
                  //                     height: 14.h,
                  //                     decoration: BoxDecoration(
                  //                       border: Border.all(
                  //                           width: 1,
                  //                           color: Colors.black),
                  //                       borderRadius:
                  //                           BorderRadius.circular(
                  //                               10.sp),
                  //                     ),
                  //                     child: Stack(
                  //                       children: [
                  //                         Positioned.fill(
                  //                           child: ClipRRect(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(
                  //                                     10.sp),
                  //                             child: Image.asset(
                  //                               'assets/image/profile.png',
                  //                               fit: BoxFit.cover,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                   ),
                  //                   3.w.widthBox,
                  //                   Column(
                  //                     mainAxisAlignment:
                  //                         MainAxisAlignment.center,
                  //                     crossAxisAlignment:
                  //                         CrossAxisAlignment.start,
                  //                     children: [
                  //                       Container(
                  //                         width: 46.w,
                  //                         child:
                  //                             item['title']
                  //                             //ads.title!.text
                  //                             // text
                  //                                 .size(12.sp)
                  //                                 .bold
                  //                                 .overflow(TextOverflow
                  //                                     .ellipsis)
                  //                                 .make(),
                  //                       ),
                  //                       1.h.heightBox,
                  //                       Row(
                  //                         children: [
                  //                           Icon(
                  //                             Icons.location_on,
                  //                             size: 12.sp,
                  //                           ),
                  //                           Container(
                  //                             width: 42.w,
                  //                             child: text
                  //                                 //data['location']
                  //                                 //ads.location!.text
                  //                                 .size(8.sp)
                  //                                 .overflow(TextOverflow
                  //                                     .ellipsis)
                  //                                 .make(),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                       .5.h.heightBox,
                  //                       //' \$  ${ads.price}'
                  //                       //'₹${data['price']}'
                  //                       text.text
                  //                           .size(12.sp)
                  //                           .color(Colors.blue)
                  //                           .make(),
                  //                       .5.h.heightBox,
                  //                       Row(
                  //                         children: [
                  //                           Icon(
                  //                             Icons
                  //                                 .watch_later_outlined,
                  //                             size: 14.sp,
                  //                           ),
                  //                           3.w.widthBox,
                  //                           Container(
                  //                             width: 36.w,
                  //                             child: text
                  //                                 //data['date']
                  //                                 //'5 hours ago'
                  //                                 .text
                  //                                 .size(8.sp)
                  //                                 .overflow(TextOverflow
                  //                                     .ellipsis)
                  //                                 .make(),
                  //                           ),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           });
                  //     }
                  //     if (snapshot.connectionState ==
                  //             ConnectionState.waiting ||
                  //         !snapshot.hasData) {
                  //       return SizedBox(
                  //           child: CircularProgressIndicator());
                  //     }
                  //     return Container();
                  //   },
                  // )

                  GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.all(10),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    //childAspectRatio: 1.3,
                    crossAxisCount: 2,
                    children: List.generate(
                      HomeState.myPublishedAds.length,
                      (i) {
                        return myAdsCard(HomeState.myPublishedAds[i]);
                      },
                    ),
                  ),

                  // if (pubAds.isNotEmpty)
                  //   for (int i = 0; i < pubAds.length; i++)
                  //     (profileAds(pubAds[i]))
                  // else
                  //   'No Data'.text.size(16.sp).bold.make().centered(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
