import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/screen/edit_profile/edit_profile.dart';
import 'package:sn_2nd/screen/login/login.dart';
import 'package:sn_2nd/screen/my_account/my_account.dart';
import 'package:sn_2nd/screen/profile/model/profile_model.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../web_services/api_provider.dart';

Widget profileBar(BuildContext context, ProfileModel data) {
  return Expanded(
    flex: 1,
    child: Container(
      width: double.infinity,
      color: Colors.blue.shade600,
      padding: EdgeInsets.symmetric(horizontal: 6.sp, vertical: 10.sp),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.arrow_back,
                size: 25.sp,
                color: Colors.white,
              ).onTap(() {
                Navigator.pop(context);
              }),
              3.w.widthBox,
              'Profile'
                  .text
                  .size(20.sp)
                  .letterSpacing(1)
                  .color(Colors.white)
                  .make(),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                        (data.username ?? '')
                            .text
                            .bold
                            .size(16.sp)
                            .color(Colors.white)
                            .make(),
                        'Active Since : ${DateFormat.yMMMMd().format(data.createdAt!)}'
                            .text
                            .size(10.sp)
                            .color(Colors.white)
                            .overflow(TextOverflow.ellipsis)
                            .make(),
                      ],
                    )
                  ],
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfilePage()),
                      ).then((value) {
                        MyAccountPageState.pData.image = value;
                      });
                    } else if (value == 2) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (route) => false,
                      );
                    }
                  },
                  shape: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10.sp),
                  ),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.more_vert,
                    size: 24.sp,
                    color: Colors.white,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      child: Text("Edit Profile"),
                      value: 1,
                    ),
                    const PopupMenuItem(
                      child: Text("Logout"),
                      value: 2,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
