import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/expired_ads/expire_ads.dart';
import 'package:sn_2nd/screen/favorite_ads/favorite_page.dart';
import 'package:sn_2nd/screen/hidden_ads/hidden_ads.dart';
import 'package:sn_2nd/screen/login/login.dart';
import 'package:sn_2nd/screen/my_account/widget/myacount_item.dart';
import 'package:sn_2nd/screen/my_ads/my_ads.dart';
import 'package:sn_2nd/screen/pending_ads/pending_ads.dart';
import 'package:sn_2nd/screen/profile/contac_details.dart';
import 'package:sn_2nd/screen/profile/model/profile_model.dart';
import 'package:sn_2nd/screen/profile/profile.dart';
import 'package:sn_2nd/screen/resubmit_ads/resubmit_ads.dart';
import 'package:sn_2nd/screen/settings/setting.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => MyAccountPageState();
}

dynamic profileData;

class MyAccountPageState extends State<MyAccountPage> {
  bool isLoading = true;
  static ProfileModel pData = ProfileModel();
  @override
  void initState() {
    super.initState();
    _getProfiledata();
    print(ApiProvider.baseUrl + '/' + (pData.image ?? ""));
  }

  _getProfiledata() async {
    // if (profileData == null) {
    Response r = await ApiProvider.getProfileData();
    if (r.statusCode == 200) {
      pData = profileModelFromJson(r.body);
      profileData = pData;
      print(pData.phone);
      print(pData.image);
    }
    setState(() {
      isLoading = false;
    });
    // }
    // else {
    //   pData = profileData;
    //   setState(() {
    //     isLoading = false;
    //   });
    // }
  }

  //_getprofileData()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? CircularProgressIndicator().centered()
          : SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 28.h,
                    width: double.infinity,
                    color: Colors.blue.shade600,
                    padding: EdgeInsets.symmetric(
                        horizontal: 6.sp, vertical: 10.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                3.w.widthBox,
                                'My Account'
                                    .text
                                    .size(18.sp)
                                    .letterSpacing(1)
                                    .color(Colors.white)
                                    .make(),
                              ],
                            ),
                            Icon(
                              Icons.person_outline,
                              color: Colors.white,
                              size: 25.sp,
                            ).onTap(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfilePage(pData: pData)));
                            }),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.sp),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: ClipOval(
                                  child: Image.network(
                                    ApiProvider.baseUrl +
                                        '/' +
                                        (pData.image ?? ""),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, _, __) {
                                      return Image.asset(
                                          'assets/image/profile.png',
                                          fit: BoxFit.cover);
                                    },
                                  ),
                                ),
                              ),
                              4.w.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  1.h.heightBox,
                                  (pData.username ?? '')
                                      .text
                                      .bold
                                      .size(16.sp)
                                      .color(Colors.white)
                                      .make(),
                                  'Active Since : ${DateFormat.yMMMMd().format(pData.createdAt!)}'
                                      .text
                                      .size(10.sp)
                                      .color(Colors.white)
                                      .make(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: ListView(
                        children: [
                          myaccountItem(Icons.library_add, 'My Ads').onTap(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyAdsPage()));
                          }),
                          myaccountItem(Icons.favorite_border, 'Favourite Ads')
                              .onTap(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavoritePage()));
                          }),
                          myaccountItem(Icons.watch_later, 'Pending Ads')
                              .onTap(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PendingAds()));
                          }),
                          myaccountItem(Icons.visibility_off, 'Hidden Ads')
                              .onTap(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HiddenAds()));
                          }),
                          myaccountItem(Icons.error_outline, 'Expire Ads')
                              .onTap(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExpireAds()));
                          }),
                          myaccountItem(Icons.update, 'Resubmit').onTap(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResubmitAds()));
                          }),
                          myaccountItem(Icons.settings, 'Settings').onTap(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingPage()));
                          }),
                          myaccountItem(Icons.contact_mail, 'Contact')
                              .onTap(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactUs()),
                            );
                          }),
                          myaccountItem(Icons.logout, 'Logout').onTap(() async {
                            final pref = await SharedPreferences.getInstance();
                            await pref.clear();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (route) => false,
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
