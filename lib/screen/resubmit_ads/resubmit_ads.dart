import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/home_page/model/featured_model.dart';
import 'package:sn_2nd/screen/resubmit_ads/widgets/resubmit_card.dart';
import 'package:sn_2nd/web_services/api_provider.dart';

import 'package:velocity_x/velocity_x.dart';

class ResubmitAds extends StatefulWidget {
  @override
  State<ResubmitAds> createState() => _ResubmitAdsState();
}

class _ResubmitAdsState extends State<ResubmitAds> {
  List<FeaturedAd> reAds = [];
  @override
  void initState() {
    super.initState();
    _favoritedAds();
  }

  _favoritedAds() async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.getResubmitAds();
    if (r.statusCode>=200 && r.statusCode<=210) {
      Featuredmodel data = featuredmodelFromJson(r.body);
      reAds = data.featuredAds!;
      print(reAds.length);
      setState(() {});
    }
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.sp),
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
                  'Resubmit Ads'.text.bold.size(20.sp).letterSpacing(1).make(),
                ],
              ),
              2.h.heightBox,
              Expanded(
                child: reAds.isEmpty
                    ? "No Data Found".text.size(16.sp).bold.make().centered()
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: reAds.length,
                        itemBuilder: (context, i) {
                          return resubmitAdsCard(reAds[i]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
