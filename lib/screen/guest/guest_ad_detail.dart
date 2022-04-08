import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/models/all_categories_model.dart';
import 'package:sn_2nd/screen/category_page/category_page.dart';
import 'package:sn_2nd/screen/description_page/add_description.dart';
import 'package:sn_2nd/screen/home_page/model/featured_model.dart';
import 'package:sn_2nd/screen/home_page/widget/ads_card.dart';
import 'package:sn_2nd/screen/home_page/widget/cat_box.dart';
import 'package:sn_2nd/screen/home_page/widget/search_box.dart';
import 'package:sn_2nd/screen/login/login.dart';
import 'package:sn_2nd/screen/my_ads/model/myads_model.dart';
import 'package:sn_2nd/screen/show_all_ads/show_all_ads.dart';
import 'package:sn_2nd/screen/sub_category_page/show_sub_categries.dart';
import 'package:sn_2nd/screen/tranding_ads/model/tranding_add_all_ads.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  GuestPageState createState() => GuestPageState();
}

class GuestPageState extends State<GuestPage> {
  bool isLoading = true;
  List<AllCategorymodel> categorymodel = [];
  List<FeaturedAd> fAds = [];
  List<AllAddmodel> allAddmodel = [];
  List<AllAddmodel> allAds = [];
  List<AllAddmodel> favAds = [];
  List<MyAdsModel> myPublishedAds = [];

  @override
  void initState() {
    super.initState();
    //getData();
    _getApi();
  }

  _getApi() async {
    Response all = await ApiProvider.getAllAdsUnauthenticated();
    print('here executed');
    print(all.statusCode);
    if (all.statusCode >= 200 && all.statusCode <= 210) {
      print(all.body);
      myPublishedAds = myAdsModelFromJson(all.body);
      print(">>>>>>>>>>>>>>>${allAds.length}");
    }

    Response rr = await ApiProvider.getAllCategory();
    if (rr.statusCode == 200) {
      categorymodel = allCategorymodelFromJson(rr.body);
    }
    setState(() {
      isLoading = false;
    });
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
                            Spacer(),
                            'Login'.text.size(16.sp).bold.make().onTap(() {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            })
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
                      3.h.heightBox,
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
                          myPublishedAds.length,
                          (i) {
                            print(allAds.length);
                            return myAdsCard(myPublishedAds[i]);
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
