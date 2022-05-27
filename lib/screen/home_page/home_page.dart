import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/chat_module/chat_list.dart';
import 'package:sn_2nd/screen/favorite_ads/favorite_page.dart';
import 'package:sn_2nd/screen/my_account/my_account.dart';
import 'package:sn_2nd/screen/nav_page/home.dart';
import 'package:sn_2nd/screen/post_ads/post_ads.dart';

import '../chat_module/controller/chat_controller.dart';
import '../chat_module/controller/chat_list_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ChatListController _chatListController = Get.put(ChatListController());
  ChatController _chatController = Get.put(ChatController());

  int i = 0;

  List<Widget> page = [
    Home(),
    FavoritePage(),
    ChatList(),
    MyAccountPage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    createFields();
    super.initState();
  }

  createFields() async {
    SharedPreferences sharedData = await SharedPreferences.getInstance();
    await sharedData.setString('adData', 'data');
    await sharedData.setString('adCategory', 'data');
    await sharedData.setString('userData', 'data');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.green,
        iconSize: 25.sp,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'home'),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(right: 25.sp),
              child: const Icon(
                Icons.favorite_outline,
              ),
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(left: 25.sp),
                child: const Icon(
                  Icons.chat_outlined,
                ),
              ),
              label: 'Chat'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Account')
        ],
        onTap: (index) {
          i = index;
          setState(() {});
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostFreeAds()));
        },
        child: Icon(
          Icons.add,
          size: 25.sp,
        ),
      ),
      body: page.elementAt(i),
    );
  }
}
