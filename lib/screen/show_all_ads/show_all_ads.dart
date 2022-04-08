import 'package:flutter/material.dart';
import 'package:sn_2nd/screen/description_page/add_description.dart';
import 'package:sn_2nd/screen/tranding_ads/model/tranding_add_all_ads.dart';
import 'package:sn_2nd/screen/tranding_ads/widget/trend_card.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

class ShowAllads extends StatefulWidget {
  List<AllAddmodel> ads;
  ShowAllads({required this.ads});

  @override
  _ShowAlladsState createState() => _ShowAlladsState();
}

class _ShowAlladsState extends State<ShowAllads> {
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
                  'All Ads'.text.size(18.sp).letterSpacing(1).bold.make(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: widget.ads.isEmpty
                    ? "No Data Found".text.size(16.sp).bold.make().centered()
                    : GridView.builder(
                        itemCount: widget.ads.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (context, i) =>
                            trendCard(widget.ads[i]).onTap(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdsDescription(
                                        data: widget.ads[i],
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
