import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/home_page/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../web_services/api_provider.dart';

class OtpVerify extends StatelessWidget {
  TextEditingController _first = TextEditingController();
  TextEditingController _second = TextEditingController();
  TextEditingController _third = TextEditingController();
  TextEditingController _fourth = TextEditingController();

  FocusNode _one = FocusNode();
  FocusNode _two = FocusNode();
  FocusNode _three = FocusNode();
  FocusNode _four = FocusNode();
  final mobile;

  OtpVerify({Key? key, required this.mobile}) : super(key: key);

  handleOtpVerify(BuildContext context) async {
    final otp = _first.text.toString() +
        _second.text.toString() +
        _third.text.toString() +
        _fourth.text.toString();

    EasyLoading.show(status: 'Getting you logged in..');

    http.Response response = await http.post(
      Uri.parse('${ApiProvider.baseUrl}/varify-otp-and-login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"number": mobile, "otp": int.parse(otp)}),
    );
    EasyLoading.dismiss();
    if (response.statusCode >= 200 && response.statusCode <= 210) {
      EasyLoading.showToast('OTP verification successful');
      var data = jsonDecode(response.body);
      print(response.body);
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
      EasyLoading.showToast('Login Successful!');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else if (response.statusCode < 410) {
      EasyLoading.showToast('Enter correct OTP');
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
                'Enter Received OTP'.text.size(16.sp).bold.make(),
                2.h.heightBox,
                Image.asset(
                  'assets/image/login.png',
                  height: 24.h,
                ),
                4.h.heightBox,
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // 1 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: TextField(
                          focusNode: _one,
                          controller: _first,
                          style: black14MediumTextStyle,
                          keyboardType: TextInputType.number,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          onChanged: (v) {
                            FocusScope.of(context).requestFocus(_two);
                          },
                        ),
                      ),
                      // 1 End
                      // 2 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: TextField(
                          focusNode: _two,
                          controller: _second,
                          style: black14MediumTextStyle,
                          keyboardType: TextInputType.number,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          onChanged: (v) {
                            FocusScope.of(context).requestFocus(_three);
                          },
                        ),
                      ),
                      // 2 End
                      // 3 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: TextField(
                          focusNode: _three,
                          controller: _third,
                          style: black14MediumTextStyle,
                          keyboardType: TextInputType.number,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          onChanged: (v) {
                            FocusScope.of(context).requestFocus(_four);
                          },
                        ),
                      ),
                      // 3 End
                      // 4 Start
                      Container(
                        width: 50.0,
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              color: Colors.black.withOpacity(0.25),
                            ),
                          ],
                        ),
                        child: TextField(
                          focusNode: _four,
                          controller: _fourth,
                          style: black14MediumTextStyle,
                          keyboardType: TextInputType.number,
                          cursorColor: primaryColor,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(18.0),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          onChanged: (v) async {
                            handleOtpVerify(context);
                          },
                        ),
                      ),
                      // 4 End
                    ],
                  ),
                ),
                4.h.heightBox,
                Container(
                  width: 70.w,
                  height: 6.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(25.sp),
                  ),
                  child: 'Verify and Login'
                      .text
                      .size(18.sp)
                      .bold
                      .color(Colors.white)
                      .make(),
                ).onTap(() async {
                  handleOtpVerify(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const TextStyle black14MediumTextStyle = TextStyle(
  fontSize: 14.0,
  color: Colors.black,
  fontWeight: FontWeight.w500,
);

const primaryColor = Colors.blue;
