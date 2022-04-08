import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_2nd/screen/category_page/category_page.dart';
import 'package:sn_2nd/screen/favorite_ads/favorite_page.dart';
import 'package:sn_2nd/screen/login/login.dart';
import 'package:sn_2nd/screen/my_ads/my_ads.dart';

import 'package:sn_2nd/screen/page_4/widget/drawer_item.dart';
import 'package:sn_2nd/screen/settings/setting.dart';

import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

import '../chat_module/chat_list.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 14.h,
            color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundImage: AssetImage(
                        'assets/image/health.png',
                      ),
                    ),
                    4.w.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        1.h.heightBox,
                        'Jhon Doe'
                            .text
                            .bold
                            .size(18.sp)
                            .color(Colors.white)
                            .make(),
                        'My Account'
                            .text
                            .size(12.sp)
                            .color(Colors.white)
                            .make(),
                      ],
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 30.sp,
                  color: Colors.white,
                ).onTap(() {
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
          drawerItem('assets/icon/category.png', 'Category').onTap(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryPage()));
          }),
          drawerItem('assets/icon/favorite.png', 'Favorite').onTap(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => FavoritePage()));
          }),
          drawerItem('assets/icon/ads.png', 'My Ads').onTap(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyAdsPage()));
          }),
          drawerItem('assets/icon/chats.png', 'Chats').onTap(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatList()));
          }),
          Container(
            width: double.infinity,
            height: 8.h,
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            //color: Colors.red,
            child: Row(
              children: [
                Image.asset(
                  'assets/icon/pages.png',
                ),
                4.w.widthBox,
                'Pages'.text.size(20.sp).make(),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 24.sp,
                  ),
                ))
              ],
            ),
          ),
          drawerItem('assets/icon/setting.png', 'Setting').onTap(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingPage()));
          }),
          drawerItem('assets/icon/phone.png', 'Contact'),
          drawerItem('assets/icon/logout.png', 'Logout').onTap(() async {
            final pref = await SharedPreferences.getInstance();
            await pref.clear();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
              (route) => false,
            );
          }),
        ],
      ),
    ));
  }
}
