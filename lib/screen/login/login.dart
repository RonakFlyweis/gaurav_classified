import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/forget_password/forget_password.dart';
import 'package:sn_2nd/screen/guest/guest_ad_detail.dart';
import 'package:sn_2nd/screen/home_page/home_page.dart';
import 'package:sn_2nd/screen/login/widget/text_field_login.dart';
import 'package:sn_2nd/screen/onboarding_screen/page_1.dart';
import 'package:sn_2nd/screen/otp_screen/otp_screen.dart';

import 'package:sn_2nd/screen/sign_up/sign_up_page.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:sn_2nd/web_services/social_media_sign_in.dart';

import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();

  TextEditingController _password = TextEditingController();

  _handleFacebook(String token, BuildContext context) async {
    print('handling facebook sign in');
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"fbToken": token});
    Response response = await post(
        Uri.parse('https://classifide-9090.herokuapp.com/login-facebook'),
        headers: headers,
        body: body);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      var data = json.decode(response.body);
      var pref = await SharedPreferences.getInstance();
      Constants.token = data['token'];
      pref.setString('token', Constants.token);
      Constants.id = data['id'];
      pref.setString('id', Constants.id);
      Constants.userName = data['name'];
      pref.setString('name', Constants.userName);
      print('here');
      print(Constants.token);
      print(Constants.id);
      print(Constants.userName);
      EasyLoading.showToast('Login Successfully!');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      EasyLoading.showToast('Invalid data!');
    }
  }

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
        child: SingleChildScrollView(
          child: Container(
            width: 100.w,
            height: 100.h,
            padding: EdgeInsets.all(15.sp),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    'Skip Login..'.text.size(10.sp).make().onTap(() {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => GuestPage()));
                    }),
                  ],
                ),
                4.h.heightBox,
                'Welcome!'.text.size(16.sp).bold.make(),
                2.h.heightBox,
                Image.asset(
                  'assets/image/login.png',
                  height: 24.h,
                ),
                2.h.heightBox,
                textFieldEmail('Enter Email', _email),
                2.h.heightBox,
                textFieldPassword('Password', _password),
                2.h.heightBox,
                Container(
                  alignment: Alignment.centerRight,
                  width: 65.w,
                  child: 'Forget Password'
                      .text
                      .size(12.sp)
                      .color(Colors.blue)
                      .make(),
                ).onTap(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ForgetPasswordPage()));
                }),
                4.h.heightBox,
                Container(
                  width: 50.w,
                  height: 6.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25.sp),
                  ),
                  child:
                      'Login'.text.size(20.sp).bold.color(Colors.white).make(),
                ).onTap(() async {
                  if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                    Response r = await ApiProvider.loginUser(
                        _email.text, _password.text);
                    EasyLoading.dismiss();

                    if (r.statusCode == 200) {
                      var data = json.decode(r.body);
                      print(r.body);
                      var pref = await SharedPreferences.getInstance();
                      Constants.token = data['token'];
                      pref.setString('token', Constants.token);
                      Constants.id = data['id'];
                      pref.setString('id', Constants.id);
                      Constants.userName = data['name'];
                      pref.setString('name', Constants.userName);
                      print('here');
                      print(Constants.token);
                      print(Constants.id);
                      print(Constants.userName);
                      EasyLoading.showToast('Login Successfully!');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      EasyLoading.showToast('Invalid data!');
                    }
                  } else {
                    EasyLoading.showToast('Enter valid data!');
                  }
                }),
                2.h.heightBox,
                'Login with phone'.text.size(14.sp).make().onTap(() {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => OtpScreen()));
                }),
                2.h.heightBox,
                Container(
                  width: 40.w,
                  height: 6.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/icon/facebook.png',
                        height: 6.h,
                      ).onTap(() async {
                        dynamic token = await SocialLogin.facebookSignIn();
                        print('generated token ' + token);
                        _handleFacebook(token, context);
                      }),
                      Image.asset(
                        'assets/icon/google.png',
                        height: 6.h,
                      ),
                    ],
                  ),
                ),
                4.h.heightBox,
                Container(
                    child: Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Sign Up',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          )
                        ]),
                  ),
                )).onTap(() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
