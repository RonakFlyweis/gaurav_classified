import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/description_page/add_description.dart';
import 'package:sn_2nd/screen/hidden_ads/widgets/hidden_card.dart';
import 'package:sn_2nd/screen/home_page/model/featured_model.dart';
import 'package:sn_2nd/screen/tranding_ads/model/tranding_add_all_ads.dart';
import 'package:sn_2nd/web_services/api_provider.dart';

import 'package:velocity_x/velocity_x.dart';

class HiddenAds extends StatefulWidget {
  @override
  State<HiddenAds> createState() => _HiddenAdsState();
}

class _HiddenAdsState extends State<HiddenAds> {
  List<AllAddmodel> hidAds = [];

  @override
  void initState() {
    super.initState();
    _favoritedAds();
  }

  _favoritedAds() async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.getHiddenAds();
    if (r.statusCode >=200 && r.statusCode<=210) {
      List<AllAddmodel> data = allAddmodelFromJson(r.body);
      hidAds = data;
      print('got hidden ads');
      print(hidAds.length);
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
                  'Hidden Ads'.text.bold.size(20.sp).letterSpacing(1).make(),
                ],
              ),
              2.h.heightBox,
              Expanded(
                child: hidAds.isEmpty
                    ? "No Data Found".text.size(16.sp).bold.make().centered()
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: hidAds.length,
                        itemBuilder: (context, i) {
                          return hiddenAdsCard(hidAds[i]).onTap(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdsDescription(
                                          data: hidAds[i],
                                        )));
                          });
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
