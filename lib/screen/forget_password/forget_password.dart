import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/forget_password/password_dialog.dart';
import 'package:sn_2nd/screen/otp_verify/otp_verify.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  TextEditingController _email = TextEditingController();

  sendOtp() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${ApiProvider.baseUrl}/email-send'));
    request.body = jsonEncode({"email": _email.text.toString()});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response.statusCode;
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
                15.h.heightBox,
                'Forget Password!'.text.size(18.sp).bold.make(),
                2.h.heightBox,
                Container(
                  width: 75.w,
                  child: 'Enter the Email Address associated with your account.'
                      .text
                      .size(12.sp)
                      .align(TextAlign.center)
                      .gray400
                      .make(),
                ),
                2.h.heightBox,
                Image.asset(
                  'assets/image/forgotpassword.png',
                  height: 24.h,
                ),
                2.h.heightBox,
                Container(
                  width: 70.w,
                  height: 5.h,
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: ' Email Id',
                      //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                4.h.heightBox,
                Container(
                  width: 60.w,
                  height: 6.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25.sp),
                  ),
                  child: 'Reset Password'
                      .text
                      .size(18.sp)
                      .color(Colors.white)
                      .make(),
                ).onTap(() async {
                  if (_email.text.isNotBlank) {
                    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                    //Response r = await ApiProvider.forgetPassword(_email.text);
                    var statusCode = await sendOtp();
                    EasyLoading.dismiss();
                    if (statusCode >= 200 || statusCode <= 210) {
                      EasyLoading.showToast(
                          'Email verification mail sent! \n Please enter otp to reset password...');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => OtpVerifyPassword(
                                email: _email.text.toString(),
                              )));

                      // showDialog(
                      //     context: context,
                      //     builder: (context) =>
                      //         passwordDialog(context, _email.text));
                    }
                  } else {
                    EasyLoading.showToast('Enter Email!');
                  }
                }),
                4.h.heightBox,
                'Go Back'
                    .text
                    .size(16.sp)
                    .bold
                    .color(Colors.blue)
                    .make()
                    .onTap(() {
                  Navigator.pop(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
