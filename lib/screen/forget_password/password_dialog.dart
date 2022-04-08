import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/login/login.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

Widget passwordDialog(BuildContext context,String email) {
  TextEditingController _otp = TextEditingController();
  TextEditingController _newPass = TextEditingController();
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      height: 30.h,
      width: 80.h,
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        color: Vx.white,
        borderRadius: BorderRadius.circular(15.sp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70.w,
            height: 5.h,
            child: TextField(
              controller: _otp,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 5.sp),
                hintText: 'Enter OTP',
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          2.h.heightBox,
          Container(
            width: 70.w,
            height: 5.h,
            child: TextField(
              controller: _newPass,
              style: TextStyle(fontSize: 14.sp),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 5.sp),
                hintText: 'Enter New Password',
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
            height: 5.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25.sp),
            ),
            child:
                'Update Password'.text.size(15.sp).color(Colors.white).make(),
          ).onTap(() async {
            if (_otp.text.isNotEmpty && _newPass.text.isNotEmpty) {
              EasyLoading.show(status: 'Loasding...', dismissOnTap: false);
              Response r = await ApiProvider.resetForgetPassword(
                  _otp.text, _newPass.text,email);
              EasyLoading.dismiss();
              if (r.statusCode == 200) {
                EasyLoading.showToast(
                    'Password changed successfully!\nYou can login now...');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } else {
                EasyLoading.showToast('Some Internal Problem!');
              }
            } else {
              EasyLoading.showToast('Enter valid data!');
            }
          })
        ],
      ),
    ),
  );
}
