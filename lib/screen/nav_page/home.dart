import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/models/all_categories_model.dart';
import 'package:sn_2nd/screen/category_page/category_page.dart';
import 'package:sn_2nd/screen/category_page/model/category_model.dart';
import 'package:sn_2nd/screen/description_page/add_description.dart';
import 'package:sn_2nd/screen/home_page/model/featured_model.dart';
import 'package:sn_2nd/screen/home_page/model/user_details_model.dart';
import 'package:sn_2nd/screen/home_page/widget/ads_card.dart';
import 'package:sn_2nd/screen/home_page/widget/cat_box.dart';
import 'package:sn_2nd/screen/home_page/widget/search_box.dart';
import 'package:sn_2nd/screen/my_ads/model/myads_model.dart';
import 'package:sn_2nd/screen/page_4/drawer_page.dart';
import 'package:sn_2nd/screen/show_all_ads/show_all_ads.dart';
import 'package:sn_2nd/screen/sub_category_page/show_sub_categries.dart';
import 'package:sn_2nd/screen/tranding_ads/model/tranding_add_all_ads.dart';
import 'package:sn_2nd/screen/tranding_ads/trending_ads.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

dynamic adData;
dynamic categoryData;
dynamic userDetails;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  bool isLoading = true;
  List<AllCategorymodel> categorymodel = [];
  List<FeaturedAd> fAds = [];
  List<AllAddmodel> allAddmodel = [];
  static List<AllAddmodel> allAds = [];
  List<AllAddmodel> favAds = [];
  static List<MyAdsModel> myPublishedAds = [];

  /*List<Category> cat = [
    Category(id: "6170479d6185af1f17651c32", category: "Cars & bikes"),
    Category(
        id: "617048136185af1f17651c34", category: "Electronic & Appliances"),
    Category(id: "617048686185af1f17651c35", category: "Home & Lifestyle"),
    Category(id: "617048c96185af1f17651c39", category: "Mobile & Tablet"),
    Category(id: "617048806185af1f17651c36", category: "Jobs"),
    Category(id: "617048956185af1f17651c37", category: "Services"),
    Category(id: "617048aa6185af1f17651c38", category: "Entertainment")
  ];*/
  @override
  void initState() {
    super.initState();
    //getData();
    _getApi();
  }

  _getApi() async {
    //Response r = await ApiProvider.getFavoriteAds();

    // if (r.statusCode == 201) {
    //   //favAds = allAddmodelFromJson(r.body);
    //   //print(favAds.length);
    // }
    // SharedPreferences sharedData = await SharedPreferences.getInstance();
    // String adData = sharedData.getString('adData')!;
    // String categoryData = sharedData.getString('adCategory')!;
    // String userData = sharedData.getString('userData')!;
    // print('printing shared pref data');
    // print(adData);
    // print(categoryData);
    // print(userData);
    //
    // if (adData == 'data' || categoryData == 'data' || userData == 'data') {
    //   Response all = await ApiProvider.getAllAds();
    //   print(all.statusCode.toString() + 'required status code');
    //   sharedData.setString('adData', jsonEncode(all.body));
    //   print('reached here');
    //   if (all.statusCode == 201) {
    //     allAds = allAddmodelFromJson(all.body);
    //     print(">>>>>>>>>>>>>>>${allAds.length}");
    //   }
    //
    //   Response rr = await ApiProvider.getAllCategory();
    //   sharedData.setString('adCategory', jsonEncode(rr.body));
    //   if (rr.statusCode == 200) {
    //     categorymodel = allCategorymodelFromJson(rr.body);
    //   }
    //
    //   Response user = await ApiProvider.getUserDetails();
    //   sharedData.setString('userData', jsonEncode(user.body));
    //   if (user.statusCode == 200) {
    //     UserDetailsModel userData = userDetailsModelFromJson(user.body);
    //
    //     Constants.id = userData.id!;
    //     setState(() {
    //       isLoading = false;
    //     });
    //   }
    // } else {
    //   allAds = allAddmodelFromJson(jsonDecode(sharedData.getString('adData')!));
    //   categorymodel = allCategorymodelFromJson(
    //       jsonDecode(sharedData.getString('adCategory')!));
    //   UserDetailsModel userData = userDetailsModelFromJson(
    //       jsonDecode(sharedData.getString('userData')!));
    //   Constants.id = userData.id!;
    //   setState(() {
    //     isLoading = false;
    //   });
    // }

    if (adData == null || categoryData == null || userDetails == null) {
      Response all = await ApiProvider.getAllAds();
      print('here executed');
      print(all.statusCode);
      if (all.statusCode == 201) {
        print(all.body);
        allAds = allAddmodelFromJson(all.body);
        adData = allAds;
        print('\n\n\n');
        print(all.body);
        print(">>>>>>>>>>>>>>>${allAds.length}");
      }

      Response myAds = await ApiProvider.getMyAds();
      print(myAds.statusCode);
      if (myAds.statusCode >= 200 && myAds.statusCode < 210) {
        print('here');
        myPublishedAds = myAdsModelFromJson(myAds.body);
        print('my total ads' + myPublishedAds.length.toString());
        print('\n\n\n');
      }

      Response rr = await ApiProvider.getAllCategory();
      if (rr.statusCode == 200) {
        categorymodel = allCategorymodelFromJson(rr.body);
        categoryData = categorymodel;
      }
      Response user = await ApiProvider.getUserDetails();
      if (user.statusCode == 200) {
        UserDetailsModel userData = userDetailsModelFromJson(user.body);
        userDetails = userData;
        Constants.id = userData.id!;
        setState(() {
          isLoading = false;
        });
      }
    } else {
      allAds = adData;
      categorymodel = categoryData;
      Constants.id = userDetails.id!;
      setState(() {
        isLoading = false;
      });
    }
    // Response all = await ApiProvider.getAllAds();
    // print('here executed');
    // print(all.statusCode);
    // if (all.statusCode == 201) {
    //   allAds = allAddmodelFromJson(all.body);
    //   print('\n\n\n');
    //   print(all.body);
    //   print(">>>>>>>>>>>>>>>${allAds.length}");
    // }
    // Response rr = await ApiProvider.getAllCategory();
    // if (rr.statusCode == 200) {
    //   categorymodel = allCategorymodelFromJson(rr.body);
    // }
    // Response user = await ApiProvider.getUserDetails();
    // if (user.statusCode == 200) {
    //   UserDetailsModel userData = userDetailsModelFromJson(user.body);
    //   userDetails = userData;
    //   Constants.id = userData.id!;
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  //getData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? CircularProgressIndicator().centered()
          : SafeArea(
              child: SizedBox(
                width: 100.w,
                height: 85.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 6.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Image.asset('assets/icons/logo.jpeg'),
                            ),
                            /*Icon(
                        Icons.menu,
                        size: 30.sp,
                      ).onTap(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DrawerPage()));
                      }),*/
                            Spacer(),
                            Icon(
                              Icons.notifications_active_outlined,
                              size: 30.sp,
                            ),
                          ],
                        ),
                      ),
                      4.h.heightBox,
                      Container(
                        width: double.infinity,
                        height: 6.h,
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                'Explore'.text.size(16.sp).bold.make(),
                                2.w.widthBox,
                                'For You'
                                    .text
                                    .size(16.sp)
                                    .color(Colors.grey)
                                    .make(),
                              ],
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    'YOU ARE IN'
                                        .text
                                        .size(10.sp)
                                        .coolGray500
                                        .make(),
                                    'India'.text.size(10.sp).make(),
                                  ],
                                ),
                                2.w.widthBox,
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 30.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      2.h.heightBox,
                      searchBox(),
                      2.h.heightBox,
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount:
                            categorymodel.length > 8 ? 8 : categorymodel.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (context, index) {
                          if (index == categorymodel.length) {
                            return Container(
                              width: 20.w,
                              height: 10.h,
                              //color: Colors.black,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.pending_outlined,
                                    size: 30.sp,
                                    color: Colors.blue,
                                  ),
                                  'View All'
                                      .text
                                      .size(8.sp)
                                      .align(TextAlign.center)
                                      .make(),
                                ],
                              ),
                            ).onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryPage()));
                            });
                          } else {
                            return catBox(
                                    ApiProvider.baseUrl +
                                        '/' +
                                        categorymodel[index].iconImage!,
                                    categorymodel[index].name!)
                                .onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowSubCategories(
                                          cat: categorymodel[index])));
                            });
                          }
                        },
                      ),
                      /*   Container(
                        width: 90.w,
                        height: 10.h,
                        //color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            catBox(
                                    ApiProvider.baseUrl +
                                        '/' +
                                        categorymodel[0].iconImage!,
                                    categorymodel[0].name!)
                                .onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowSubCategories(
                                          cat: categorymodel[0])));
                            }),
                            catBox(
                                    ApiProvider.baseUrl +
                                        '/' +
                                        categorymodel[1].iconImage!,
                                    categorymodel[1].name!)
                                .onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowSubCategories(
                                          cat: categorymodel[1])));
                            }),
                            catBox(
                                    ApiProvider.baseUrl +
                                        '/' +
                                        categorymodel[2].iconImage!,
                                    categorymodel[2].name!)
                                .onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowSubCategories(
                                          cat: categorymodel[2])));
                            }),
                            catBox(
                                    ApiProvider.baseUrl +
                                        '/' +
                                        categorymodel[3].iconImage!,
                                    categorymodel[3].name!)
                                .onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowSubCategories(
                                          cat: categorymodel[3])));
                            }),
                          ],
                        ),
                      ),
                      1.h.heightBox, */
                      /*  Container(
                        width: 90.w,
                        height: 10.h,
                        //color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            catBox(
                                    ApiProvider.baseUrl +
                                        '/' +
                                        categorymodel[4].iconImage!,
                                    categorymodel[4].name!)
                                .onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowSubCategories(
                                          cat: categorymodel[4])));
                            }),
                            catBox(
                                    ApiProvider.baseUrl +
                                        '/' +
                                        categorymodel[5].iconImage!,
                                    categorymodel[5].name!)
                                .onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowSubCategories(
                                          cat: categorymodel[5])));
                            }),
                            catBox(
                                    ApiProvider.baseUrl +
                                        '/' +
                                        categorymodel[6].iconImage!,
                                    categorymodel[6].name!)
                                .onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowSubCategories(
                                          cat: categorymodel[6])));
                            }),
                            Container(
                              width: 20.w,
                              height: 10.h,
                              //color: Colors.black,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.pending_outlined,
                                    size: 30.sp,
                                    color: Colors.blue,
                                  ),
                                  'View All'
                                      .text
                                      .size(8.sp)
                                      .align(TextAlign.center)
                                      .make(),
                                ],
                              ),
                            ).onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryPage()));
                            }),
                          ],
                        ),
                      ),
                       */
                      3.h.heightBox,
                      // Container(
                      //   width: double.infinity,
                      //   padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       'Favourite Ads'.text.size(16.sp).make(),
                      //       'View More'
                      //           .text
                      //           .size(14.sp)
                      //           .color(Colors.blue)
                      //           .overflow(TextOverflow.ellipsis)
                      //           .make()
                      //           .onTap(() {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => TrendingAdsPage(
                      //                     //fAds: fAds,
                      //                     )));
                      //       }),
                      //     ],
                      //   ),
                      // ),
                      // 2.h.heightBox,
//                       Container(
//                         width: double.infinity,
//                         //color: Colors.red,
//                         alignment: Alignment.centerLeft,
//                         height: 17.h,
//                         child: FutureBuilder(
//                           future: ApiProvider.getFavoriteAds(),
//                           builder: (BuildContext context,
//                               AsyncSnapshot<dynamic> snapshot) {
//                             if (snapshot.connectionState ==
//                                     ConnectionState.done &&
//                                 snapshot.hasData) {
//                               return Expanded(
//                                 child: ListView.builder(
//                                   shrinkWrap: true,
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: snapshot.data.length,
//                                   itemBuilder: (context, i) {
//                                     final data = snapshot.data[i];
//                                     print('daTA');
//                                     print(data);
//                                     return Container(
//                                       height: 15.h,
//                                       width: double.infinity,
// //color: Colors.red,
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             width: 40.w,
//                                             height: 14.h,
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: Colors.black),
//                                               borderRadius:
//                                                   BorderRadius.circular(10.sp),
//                                             ),
//                                             child: Stack(
//                                               children: [
//                                                 Positioned.fill(
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             10.sp),
//                                                     child: Image.asset(
//                                                       'assets/image/health.png',
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 Positioned(
//                                                   right: 2.w,
//                                                   top: 1.h,
//                                                   child: Icon(
//                                                     Icons.favorite,
//                                                     color: Colors.red,
//                                                     size: 25.sp,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           3.w.widthBox,
//                                           Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Container(
//                                                 width: 46.w,
//                                                 child: data['title']
//                                                     .toString()
//                                                     .text
//                                                     .size(12.sp)
//                                                     .bold
//                                                     .overflow(
//                                                         TextOverflow.ellipsis)
//                                                     .make(),
//                                               ),
//                                               1.h.heightBox,
//                                               Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.location_on,
//                                                     size: 12.sp,
//                                                   ),
//                                                   Container(
//                                                     width: 42.w,
//                                                     child: data['location']
//                                                         .toString()
//                                                         .text
//                                                         .size(8.sp)
//                                                         .overflow(TextOverflow
//                                                             .ellipsis)
//                                                         .make(),
//                                                   ),
//                                                 ],
//                                               ),
//                                               .5.h.heightBox,
//                                               data['price']
//                                                   .toString()
//                                                   .text
//                                                   .size(12.sp)
//                                                   .color(Colors.blue)
//                                                   .make(),
//                                               .5.h.heightBox,
//                                               Row(
//                                                 children: [
//                                                   Icon(
//                                                     Icons.watch_later_outlined,
//                                                     size: 14.sp,
//                                                   ),
//                                                   3.w.widthBox,
//                                                   Container(
//                                                     width: 36.w,
//                                                     child: '5 hours ago'
//                                                         .text
//                                                         .size(8.sp)
//                                                         .overflow(TextOverflow
//                                                             .ellipsis)
//                                                         .make(),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     );
// // return favCard(allAddmodel[i]).onTap(() {
// //   Navigator.push(
// //       context,
// //       MaterialPageRoute(
// //           builder: (context) => AdsDescription(
// //                 data: allAddmodel[i],
// //               )));
// // });
//                                   },
//                                 ),
//                               );
//                             }
//                             if (snapshot.connectionState ==
//                                     ConnectionState.waiting ||
//                                 !snapshot.hasData) {
//                               return Center(
//                                   child: SizedBox(
//                                       height: 40,
//                                       width: 40,
//                                       child: CircularProgressIndicator()));
//                             }
//                             return Container();
//                           },
//                         ),
//                         // favAds.length == 0
//                         //     ? 'No Data'.text.size(16.sp).bold.make().centered()
//                         //     : ListView.builder(
//                         //         scrollDirection: Axis.horizontal,
//                         //         itemCount: favAds.length,
//                         //         itemBuilder: (context, i) {
//                         //           return adsCard(favAds[i]).onTap(() {
//                         //             Navigator.push(
//                         //                 context,
//                         //                 MaterialPageRoute(
//                         //                     builder: (context) =>
//                         //                         AdsDescription(
//                         //                           data: favAds[i],
//                         //                         )));
//                         //           });
//                         //         },
//                         //       ),
//                       ),
                      2.h.heightBox,
                      Container(
                        height: 8.h,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 10.sp),
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 1, color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                'Looking for car in Budget?'
                                    .text
                                    .size(12.sp)
                                    .coolGray400
                                    .make(),
                                .5.h.heightBox,
                                'We have Millions'.text.size(12.sp).bold.make(),
                              ],
                            ),
                            Container(
                              height: 6.h,
                              width: 26.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: 'Explore Now'
                                  .text
                                  .size(12.sp)
                                  .color(Colors.white)
                                  .make(),
                            ),
                          ],
                        ),
                      ),
                      4.h.heightBox,
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 15.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            'All Ads'.text.size(16.sp).bold.make(),
                            'View More'
                                .text
                                .size(14.sp)
                                .color(Colors.blue)
                                .overflow(TextOverflow.ellipsis)
                                .make()
                                .onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ShowAllads(
                                            ads: allAds,
                                          )));
                            }),
                          ],
                        ),
                      ),
                      2.h.heightBox,
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.all(15),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.3,
                        crossAxisCount: 2,
                        children: List.generate(
                          allAds.length,
                          (i) {
                            return adsCard(allAds[i]).onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdsDescription(
                                            data: allAds[i],
                                          )));
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
