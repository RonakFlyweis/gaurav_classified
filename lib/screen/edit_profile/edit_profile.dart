import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/edit_profile/widget/edit_textfield.dart';
import 'package:sn_2nd/screen/my_account/my_account.dart';
import 'package:sn_2nd/web_services/api_provider.dart';

import 'package:velocity_x/velocity_x.dart';

import '../profile/model/profile_model.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File _image = File("");
  bool isImageChanged = false;
  TextEditingController _name =
      TextEditingController(text: MyAccountPageState.pData.name ?? "");
  TextEditingController _about =
      TextEditingController(text: MyAccountPageState.pData.aboutUs ?? "");
  TextEditingController _mob =
      TextEditingController(text: MyAccountPageState.pData.phone ?? "");
  TextEditingController _email =
      TextEditingController(text: MyAccountPageState.pData.email ?? "");
  TextEditingController _web =
      TextEditingController(text: MyAccountPageState.pData.website ?? "");
  TextEditingController _add =
      TextEditingController(text: MyAccountPageState.pData.address ?? "");
  TextEditingController _fb =
      TextEditingController(text: MyAccountPageState.pData.facebook ?? "");
  TextEditingController _insta =
      TextEditingController(text: MyAccountPageState.pData.instagram ?? "");

  _getProfiledata() async {
    Response r = await ApiProvider.getProfileData();

    if (r.statusCode == 200) {
      MyAccountPageState.pData = profileModelFromJson(r.body);
      profileData = MyAccountPageState.pData;
      print(MyAccountPageState.pData.phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 24.h,
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
                              size: 20.sp,
                              color: Colors.white,
                            ).onTap(() {
                              Navigator.pop(context);
                            }),
                            3.w.widthBox,
                            'Edit Profile'
                                .text
                                .size(18.sp)
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
                          EasyLoading.show(status: 'Loading...');
                          Response r = await ApiProvider.editProfile(
                              _name.text.toString(),
                              _about.text.toString(),
                              _mob.text.toString(),
                              _email.text.toString(),
                              _web.text.toString(),
                              _add.text.toString(),
                              _fb.text.toString(),
                              _insta.text.toString(),
                              _image.path == ''
                                  ? MyAccountPageState.pData.image
                                  : _image.path,
                              isImageChanged);
                          EasyLoading.dismiss();
                          if (r.statusCode == 200) {
                            EasyLoading.show(status: 'Updating Profile...');
                            await _getProfiledata();
                            EasyLoading.dismiss();
                            EasyLoading.showToast(
                                'Profile updated successfully!');

                            Navigator.pop(
                                context,
                                _image.path == ''
                                    ? MyAccountPageState.pData.image
                                    : _image.path);
                          } else {
                            EasyLoading.showError('Invalid Data!');
                          }
                        }),
                      ],
                    ),
                    Container(
                      height: 12.h,
                      width: 26.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: _image.path != ''
                                ? Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(_image),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 20.w,
                                    height: 20.w,
                                    child: ClipOval(
                                      child: Image.network(
                                        ApiProvider.baseUrl +
                                            '/' +
                                            (MyAccountPageState.pData.image ??
                                                ""),
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, _, __) {
                                          return Icon(
                                            Icons.person,
                                            size: 60.sp,
                                            color: Colors.black,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                          ),
                          Positioned(
                            bottom: 2.h,
                            right: 4.w,
                            child: Container(
                                padding: EdgeInsets.all(3.sp),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: Colors.red,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  size: 20.sp,
                                  color: Colors.white,
                                )).onTap(() {
                              _pickImage(ImageSource.gallery);
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              2.h.heightBox,
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Basic Info'.text.size(18.sp).letterSpacing(1).make(),
                    3.h.heightBox,
                    'Name'.text.size(16.sp).make(),
                    textFieldEdit('Name', _name),
                    3.h.heightBox,
                    'About Us'.text.size(18.sp).letterSpacing(1).make(),
                    1.h.heightBox,
                    textFieldEdit('Something About you', _about),
                    4.h.heightBox,
                    'Contact Information'
                        .text
                        .size(18.sp)
                        .letterSpacing(1)
                        .make(),
                    2.h.heightBox,
                    'Mobile No.'.text.size(16.sp).make(),
                    textFieldEdit('Mobile number', _mob),
                    2.h.heightBox,
                    'Emails'.text.size(16.sp).make(),
                    textFieldEdit('Email Id', _email),
                    2.h.heightBox,
                    'Website'.text.size(16.sp).make(),
                    textFieldEdit('Website', _web),
                    2.h.heightBox,
                    'Address'.text.size(16.sp).make(),
                    textFieldEdit('address', _add),
                    4.h.heightBox,
                    'Social Network'.text.size(18.sp).letterSpacing(1).make(),
                    2.h.heightBox,
                    'Facebook'.text.size(16.sp).make(),
                    textFieldEdit('#', _fb),
                    2.h.heightBox,
                    'Instagram'.text.size(16.sp).make(),
                    textFieldEdit('#', _insta),
                    5.h.heightBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage(ImageSource imageSource) async {
    final picker = ImagePicker();

    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        print(pickedFile.name);
        isImageChanged = true;
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
