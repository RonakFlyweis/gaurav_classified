import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/chat_list.dart';
import 'package:sn_2nd/screen/chat_module/chat_screen.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_list_controller.dart';
import 'package:sn_2nd/screen/tranding_ads/model/tranding_add_all_ads.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

class AdsDescription extends StatefulWidget {
  AllAddmodel data;
  AdsDescription({required this.data});

  @override
  State<AdsDescription> createState() => _AdsDescriptionState();
}

class _AdsDescriptionState extends State<AdsDescription> {
  bool fav = false;

  @override
  Widget build(BuildContext context) {
    // print(widget.data.like!.contains(Constants.id));
    for (int i = 0; i < widget.data.like!.length; i++)
      if (widget.data.like![i] == Constants.id) fav = true;
    print(Constants.id);
    print(fav);
    // if (widget.data.like!.contains(Constants.id)) fav = true;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 30.h,
                      child: Image.network(
                        ApiProvider.baseUrl + "/" + widget.data.image![0],
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return Image.asset(
                            'assets/image/health.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 3.w,
                      left: 3.w,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                          size: 25.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                2.h.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      '${widget.data.title}'
                          .text
                          .size(18.sp)
                          .bold
                          .make()
                          .w(60.w),
                      1.h.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data.userId!.username,
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          if (Constants.id != widget.data.userId!.id)
                            ElevatedButton(
                                onPressed: () {
                                  ChatListController _chatListController =
                                      Get.find();
                                  _chatListController.createGroup(
                                      widget.data.userId!.id,
                                      widget.data.userId!.username);
                                  ChatController _chatController = Get.find();
                                  _chatController.groupId = Constants.id +
                                      "-" +
                                      widget.data.userId!.id;
                                  Get.to(() => ChatScreen(
                                      name: widget.data.userId!.username));
                                },
                                child: Text('Message'))
                        ],
                      ),

                      Divider(thickness: 1, color: Vx.gray300),
                      1.h.heightBox,
                      '${widget.data.description}'
                          .text
                          .justify
                          .size(14.sp)
                          .make(),
                      Divider(thickness: 1, color: Vx.gray300),
                      1.h.heightBox,
                      Row(
                        children: [
                          'Price - ₹'
                              .text
                              .size(18.sp)
                              .bold
                              .blue500
                              .letterSpacing(1.5)
                              .make(),
                          '${widget.data.price}'
                              .text
                              .size(16.sp)
                              .blue500
                              .bold
                              .make(),
                          Spacer(),
                          Icon(
                            Icons.favorite,
                            color: !fav ? Vx.black : Vx.red500,
                            size: 30.sp,
                          ).onTap(() async {
                            if (!fav) {
                              // EasyLoading.show(
                              //     status: 'Loading...', dismissOnTap: false);
                              ApiProvider.addLikes(widget.data.id);
                              //EasyLoading.dismiss();
                              fav = true;
                            }

                            setState(() {});
                          }),
                          2.w.widthBox,
                        ],
                      ),
                      Divider(thickness: 1, color: Vx.gray300),
                      2.h.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Location '
                              .text
                              .size(14.sp)
                              .black
                              .letterSpacing(1.5)
                              .make(),
                          '${widget.data.location}'.text.size(14.sp).make(),
                        ],
                      ).px(10),
                      Divider(thickness: 1, color: Vx.gray300),
                      1.h.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Category '
                              .text
                              .size(14.sp)
                              .black
                              .letterSpacing(1.5)
                              .make(),
                          '${widget.data.category}'.text.size(14.sp).make(),
                        ],
                      ).px(10),
                      Divider(thickness: 1, color: Vx.gray300),
                      1.h.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Sub-Category '
                              .text
                              .size(14.sp)
                              .black
                              .letterSpacing(1.5)
                              .make(),
                          '${widget.data.subCategory}'.text.size(14.sp).make(),
                        ],
                      ).px(10),
                      Divider(thickness: 1, color: Vx.gray300),
                      // 1.h.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     'Brand Name '
                      //         .text
                      //         .size(14.sp)
                      //         .black
                      //         .letterSpacing(1.5)
                      //         .make(),
                      //     '${widget.data.brandName}'.text.size(14.sp).make(),
                      //   ],
                      // ).px(10),
                      // Divider(thickness: 1, color: Vx.gray300),
                      1.h.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Negotiable '
                              .text
                              .size(14.sp)
                              .black
                              .letterSpacing(1.5)
                              .make(),
                          '${widget.data.negotitate}'.text.size(14.sp).make(),
                        ],
                      ).px(10),
                      Divider(thickness: 1, color: Vx.gray300),
                      // 1.h.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     'City '
                      //         .text
                      //         .size(14.sp)
                      //         .black
                      //         .letterSpacing(1.5)
                      //         .make(),
                      //     '${widget.data.city}'.text.size(14.sp).make(),
                      //   ],
                      // ).px(10),
                      // Divider(thickness: 1, color: Vx.gray300),
                      // 1.h.heightBox,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     'Features '
                      //         .text
                      //         .size(14.sp)
                      //         .black
                      //         .letterSpacing(1.5)
                      //         .make(),
                      //     '${widget.data.features}'.text.size(14.sp).make(),
                      //   ],
                      // ).px(10),
                      // Divider(thickness: 1, color: Vx.gray300),
                      1.h.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          'Mobile Number '
                              .text
                              .size(14.sp)
                              .black
                              .letterSpacing(1.5)
                              .make(),
                          '${widget.data.mobileNumber}'.text.size(14.sp).make(),
                        ],
                      ).px(10),
                      Divider(thickness: 1, color: Vx.gray300),
                    ],
                  ),
                ),
                5.h.heightBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}
