import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/home_page/home_page.dart';
import 'package:sn_2nd/screen/login/login.dart';

import 'package:sn_2nd/screen/sign_up/sign_up_page.dart';

import 'package:velocity_x/velocity_x.dart';

import '../chat_module/controller/user_for_chat_controller.dart';

class Page_1 extends StatefulWidget {
  const Page_1({Key? key}) : super(key: key);

  @override
  State<Page_1> createState() => _Page_1State();
}

class _Page_1State extends State<Page_1> {
  UserForChatController _chatController = Get.put(UserForChatController());
  @override
  void initState() {
    isLogin();
    super.initState();
  }

  isLogin() async {
    var pref = await SharedPreferences.getInstance();
    var token = await pref.getString('token');
    var id = await pref.getString('id');
    var name = await pref.getString('name');
    if (token != null && id != null && name != null) {
      Constants.token = token;
      Constants.id = id;
      Constants.userName = name;
      print(id);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => HomePage())),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 100.w,
          height: 100.h,
          padding: EdgeInsets.all(15.sp),
          child: Column(
            children: [
              /* Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  'Skip'.text.size(14.sp).make(),
                  Icon(Icons.arrow_forward_ios)
                ],
              ).onTap(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }), */
              5.h.heightBox,
              Image.asset(
                'assets/image/welcome.png',
                height: 20.h,
              ),
              3.h.heightBox,
              'Welcome'.text.size(28.sp).bold.make(),
              2.h.heightBox,
              Container(
                width: 75.w,
                child:
                    'App allows to take picture of your recipts and save the recipts information.'
                        .text
                        .size(14.sp)
                        .align(TextAlign.center)
                        .gray400
                        .make(),
              ),
              8.h.heightBox,
              Container(
                width: 80.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 7.h,
                      width: 30.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(25.sp),
                      ),
                      child:
                          'Login'.text.size(16.sp).color(Colors.white).make(),
                    ).onTap(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }),
                    Container(
                      height: 7.h,
                      width: 30.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(25.sp),
                      ),
                      child: 'Sign Up'.text.size(16.sp).make(),
                    )
                  ],
                ),
              ).onTap(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInPage()));
              }),
              2.h.heightBox,
              'Or via Social Media'.text.size(12.sp).make(),
              4.h.heightBox,
              Container(
                width: 50.w,
                height: 6.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/icon/facebook.png',
                      height: 6.h,
                    ),
                    Image.asset(
                      'assets/icon/google.png',
                      height: 6.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
