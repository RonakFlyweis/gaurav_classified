import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/forget_password/password_dialog.dart';
import 'package:sn_2nd/screen/login/login.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class OtpVerifyPassword extends StatefulWidget {
  final String email;
  const OtpVerifyPassword({Key? key, required this.email}) : super(key: key);

  @override
  State<OtpVerifyPassword> createState() => _OtpVerifyPasswordState();
}

class _OtpVerifyPasswordState extends State<OtpVerifyPassword> {
  //final _email = TextEditingController();
  final _code = TextEditingController();
  final _password = TextEditingController();

  resetPassword() async {
    var headers = {'Content-Type': 'application/json'};
    var url = '${ApiProvider.baseUrl}/change-password';
    print(widget.email);
    print(_code.text);
    print(_password.text);
    var body = jsonEncode({
      "email": widget.email,
      "code": _code.text.toString(),
      "password": _password.text.toString()
    });
    http.Response response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    return response;
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
                Container(
                  width: 70.w,
                  height: 5.h,
                  child: TextField(
                    controller: _code,
                    decoration: InputDecoration(
                      hintText: ' OTP',
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
                  width: 70.w,
                  height: 5.h,
                  child: TextField(
                    obscureText: true,
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: 'New Password',
                      //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
                      prefixIcon: Icon(
                        Icons.password,
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
                  if (_code.text.isNotEmpty && _password.text.isNotEmpty) {
                    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                    // //Response r = await ApiProvider.forgetPassword(_email.text);
                    http.Response response = await resetPassword();
                    EasyLoading.dismiss();
                    print(response.statusCode);
                    print(response.body);
                    if (response.statusCode >= 200 &&
                        response.statusCode < 210) {
                      EasyLoading.showSuccess('Password change successful');
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } else {
                      EasyLoading.showSuccess(
                          'Some error occured, try again later');
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }
                  } else {
                    EasyLoading.showToast('Fill all fields!');
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
