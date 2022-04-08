import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/settings/widget/textfield_setting.dart';
import 'package:sn_2nd/web_services/api_provider.dart';

import 'package:velocity_x/velocity_x.dart';

import '../my_account/my_account.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController _name =
      TextEditingController(text: MyAccountPageState.pData.name ?? "");
  TextEditingController _email =
      TextEditingController(text: MyAccountPageState.pData.email ?? "");
  TextEditingController _currentPass = TextEditingController();
  TextEditingController _newPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                // height: 25.h,
                width: double.infinity,
                color: Colors.blue.shade600,
                padding:
                    EdgeInsets.symmetric(horizontal: 6.sp, vertical: 10.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.close,
                              size: 25.sp,
                              color: Colors.white,
                            ).onTap(() {
                              Navigator.pop(context);
                            }),
                            3.w.widthBox,
                            'Settings'
                                .text
                                .size(20.sp)
                                .letterSpacing(1)
                                .color(Colors.white)
                                .make(),
                          ],
                        ),
                        'Save'
                            .text
                            .size(14.sp)
                            .color(Colors.white)
                            .make()
                            .onTap(() async {
                          if (_name.text.isNotEmpty &&
                              _newPass.text.isNotEmpty &&
                              _currentPass.text.isNotEmpty &&
                              _email.text.isNotEmpty) {
                            EasyLoading.show(
                                status: 'Loading...', dismissOnTap: false);
                            Response r = await ApiProvider.changePassword(
                                _currentPass.text.toString(),
                                _newPass.text.toString());
                            EasyLoading.dismiss();
                            print(r.statusCode);
                            print(r.body);
                            if (r.statusCode >= 200 && r.statusCode <= 210) {
                              EasyLoading.showToast(
                                  'Password changed successful');
                              Navigator.of(context).pop();
                            } else {
                              EasyLoading.showToast('Wrong current password entered');
                            }
                          } else if (_currentPass.text != _newPass.text) {
                            EasyLoading.showToast('Password does not Match!');
                          } else {
                            EasyLoading.showToast('Enter valid data!');
                          }
                        }),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: ClipOval(
                              child: Image.network(
                                ApiProvider.baseUrl +
                                    '/' +
                                    (MyAccountPageState.pData.image ?? ""),
                                fit: BoxFit.cover,
                                errorBuilder: (context, _, __) {
                                  return Image.asset('assets/image/profile.png',
                                      fit: BoxFit.cover);
                                },
                              ),
                            ),
                          ),
                          4.w.widthBox,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              1.h.heightBox,
                              (MyAccountPageState.pData.username ?? '')
                                  .text
                                  .bold
                                  .size(16.sp)
                                  .color(Colors.white)
                                  .make(),
                              'Active Since : ${DateFormat.yMMMMd().format(MyAccountPageState.pData.createdAt!)}'
                                  .text
                                  .size(10.sp)
                                  .color(Colors.white)
                                  .make(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: SizedBox(
                    width: 100.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        2.h.heightBox,
                        'Basic Info'.text.bold.size(16.sp).make(),
                        3.h.heightBox,
                        'Name'.text.size(18.sp).letterSpacing(1).make(),
                        textFieldSetting('Name', _name),
                        2.h.heightBox,
                        'Email'.text.size(18.sp).letterSpacing(1).make(),
                        textFieldSetting('Email Id', _email),
                        5.h.heightBox,
                        'Change Password'.text.bold.size(16.sp).make(),
                        3.h.heightBox,
                        'Current Password'
                            .text
                            .size(18.sp)
                            .letterSpacing(1)
                            .make(),
                        textFieldSettingPass('Password', _currentPass),
                        2.h.heightBox,
                        'New Password'.text.size(18.sp).letterSpacing(1).make(),
                        textFieldSettingPass('Password', _newPass),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
