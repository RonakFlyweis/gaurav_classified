import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/description_page/add_description.dart';
import 'package:sn_2nd/screen/home_page/model/featured_model.dart';
import 'package:sn_2nd/screen/tranding_ads/widget/trend_card.dart';
import 'package:sn_2nd/web_services/api_provider.dart';

import 'package:velocity_x/velocity_x.dart';

import 'model/tranding_add_all_ads.dart';

class TrendingAdsPage extends StatefulWidget {
  @override
  State<TrendingAdsPage> createState() => _TrendingAdsPageState();
}

class _TrendingAdsPageState extends State<TrendingAdsPage> {
  List<AllAddmodel> allAddmodel = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getApi();
  }

  _getApi() async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.getFavoriteAds();

    print('----------------------------');
    if (r.statusCode == 201) {
      allAddmodel = allAddmodelFromJson(r.body);
    }
    EasyLoading.dismiss();
    print(allAddmodel.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            1.h.heightBox,
            Container(
              width: double.infinity,
              height: 10.h,
              padding: EdgeInsets.all(10.sp),
              //color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Trending Ads'.text.size(18.sp).letterSpacing(1).bold.make(),
                  'View More'.text.size(14.sp).color(Colors.blue).make(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: allAddmodel.isEmpty
                    ? "No Data Found".text.size(16.sp).bold.make().centered()
                    : GridView.builder(
                        itemCount: allAddmodel.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (context, i) =>
                            trendCard(allAddmodel[i]).onTap(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdsDescription(
                                        data: allAddmodel[i],
                                      )));
                        }),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
