import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:sizer/sizer.dart';

import 'package:sn_2nd/screen/otp_screen/otp_verify.dart';
import 'package:http/http.dart' as http;
import 'package:sn_2nd/web_services/api_provider.dart';

import 'package:velocity_x/velocity_x.dart';

class OtpScreen extends StatelessWidget {
  TextEditingController _mobile = TextEditingController();

  handleOtpSending(BuildContext context) async {
    EasyLoading.show(status: 'Sending OTP..');

    http.Response response = await http.post(
        Uri.parse('${ApiProvider.baseUrl}/sms'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"number": _mobile.text.toString()}));
    EasyLoading.dismiss();
    print(response.body);
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      EasyLoading.showToast(
          'Otp send to your mobile number +91 ${_mobile.text.toString()}');
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OtpVerify(
                mobile: _mobile.text.toString(),
              )));
    } else if (response.statusCode < 410) {
      EasyLoading.showToast('Enter correct 10 digit registered mobile number');
    } else {
      EasyLoading.showToast('Some error occured please try again later');
      Navigator.of(context).pop();
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
                4.h.heightBox,
                'Enter Mobile'.text.size(16.sp).bold.make(),
                2.h.heightBox,
                Image.asset(
                  'assets/image/login.png',
                  height: 24.h,
                ),
                4.h.heightBox,
                Container(
                  width: 75.w,
                  height: 5.h,
                  child: TextField(
                    controller: _mobile,
                    decoration: InputDecoration(
                      hintText: 'Phone-Number',
                      //contentPadding: EdgeInsets.symmetric(vertical: 10.sp),
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: Colors.grey,
                      ),
                      prefixText: '+91  ',
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
                  width: 50.w,
                  height: 6.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25.sp),
                  ),
                  child: 'Send OTP'
                      .text
                      .size(18.sp)
                      .bold
                      .color(Colors.white)
                      .make(),
                ).onTap(() {
                  handleOtpSending(context);
                  // if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
                  //   EasyLoading.show(status: 'Loading...', dismissOnTap: false);
                  //   Response r = await ApiProvider.loginUser(
                  //       _email.text, _password.text);
                  //   EasyLoading.dismiss();
                  //
                  //   if (r.statusCode == 200) {
                  //     var data = json.decode(r.body);
                  //     print(r.body);
                  //     var pref = await SharedPreferences.getInstance();
                  //     Constants.token = data['token'];
                  //     pref.setString('token', Constants.token);
                  //     Constants.id = data['id'];
                  //     pref.setString('id', Constants.id);
                  //     Constants.userName = data['name'];
                  //     pref.setString('name', Constants.userName);
                  //     print('here');
                  //     print(Constants.token);
                  //     print(Constants.id);
                  //     print(Constants.userName);
                  //     EasyLoading.showToast('Login Successfully!');
                  //     Navigator.pushReplacement(context,
                  //         MaterialPageRoute(builder: (context) => HomePage()));
                  //   } else {
                  //     EasyLoading.showToast('Invalid data!');
                  //   }
                  // } else {
                  //   EasyLoading.showToast('Enter valid data!');
                  // }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
