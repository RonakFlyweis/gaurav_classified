import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as g;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/controller/user_for_chat_controller.dart';
import 'package:sn_2nd/screen/login/login.dart';
import 'package:sn_2nd/screen/sign_up/model/signup_model.dart';
import 'package:sn_2nd/screen/sign_up/widget/textfield_signup.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class SignInPage extends StatelessWidget {
  TextEditingController _name = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 100.h,
            padding: EdgeInsets.all(15.sp),
            child: Column(
              children: [
                7.h.heightBox,
                'Sign Up'.text.size(24.sp).bold.make(),
                2.h.heightBox,
                'Fill the details & create your account'
                    .text
                    .size(14.sp)
                    .color(Colors.grey.shade600)
                    .make(),
                6.h.heightBox,
                textFieldSignup('User Name', Icons.person, _name),
                2.h.heightBox,
                textFieldMobSignup('Mobile Number', Icons.call, _mobile),
                2.h.heightBox,
                textFieldSignup('Email Id', Icons.email, _email),
                2.h.heightBox,
                textFieldPassSignup(
                    'Password (Minimum 8 Digits)', Icons.lock_open, _password),
                6.h.heightBox,
                Container(
                  width: 50.w,
                  height: 6.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25.sp),
                  ),
                  child: 'Sign Up'
                      .text
                      .size(18.sp)
                      .bold
                      .color(Colors.white)
                      .make(),
                ).onTap(() async {
                  if (_email.text.isNotEmpty &&
                      _name.text.isNotEmpty &&
                      _mobile.text.isNotEmpty &&
                      _password.text.isNotEmpty) {
                    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                    Response r = await ApiProvider.registerUser(
                      _name.text,
                      _email.text,
                      _password.text,
                      int.parse(_mobile.text),
                    );
                    EasyLoading.dismiss();
                    if (r.statusCode == 200) {
                      /*SignupModel data = signupModelFromJson(r.body);
                      Constants.userName = data.user!.username!;
                      Constants.email = data.user!.email!;
                      Constants.password = data.user!.password!;
                      Constants.phone = data.user!.phone!;
                      Constants.ownership = data.user!.ownership!;
                      Constants.id = data.user!.id!;*/
                      var data = jsonDecode(r.body);

                      UserForChatController _userForChatController =
                          g.Get.find();
                      _userForChatController.addUserInFirebase(
                          data['user']['username'], data['user']['_id']);
                      EasyLoading.showToast('${jsonDecode(r.body)['msg']}');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } else {
                      EasyLoading.showToast('Enter Valid data');
                    }
                  } else {
                    EasyLoading.showToast('Enter value in all fields');
                  }
                }),
                3.h.heightBox,
                'Login via  Social Media'.text.size(12.sp).make(),
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
                      ),
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
                            text: ' Sign In',
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          )
                        ]),
                  ),
                )).onTap(() {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
