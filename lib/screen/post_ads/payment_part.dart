import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sn_2nd/screen/post_ads/widget/payment_for_plane.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

class PaymentPart extends StatefulWidget {
  const PaymentPart({Key? key}) : super(key: key);

  @override
  _PaymentPartState createState() => _PaymentPartState();
}

class _PaymentPartState extends State<PaymentPart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ).onTap(() {
          Navigator.of(context).pop();
        }),
        title: RichText(
          text: TextSpan(
            text: 'CHOOSE ',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.green, fontSize: 19),
            children: <TextSpan>[
              TextSpan(
                  text: 'PACKAGES',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              TextSpan(
                  text: '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            25.h.heightBox,

            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 1, color: Colors.purple)),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Select Date',
                              contentPadding: EdgeInsets.all(15),
                              border: InputBorder.none),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 1,
                                color: Colors.purple,
                                style: BorderStyle.solid)),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Select Time',
                              contentPadding: EdgeInsets.all(15),
                              border: InputBorder.none),
                          onChanged: (value) {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        width: 300,
                        height: 4.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                width: 1,
                                color: Colors.purple,
                                style: BorderStyle.solid)),
                        child: 'Price : 500'
                            .text
                            .bold
                            .center
                            .size(19)
                            .make()
                            .pOnly(top: 0.5.h),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(11.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PaymentMethod()));
                },
                child: Container(
                  height: 6.h,
                  width: 24.w,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: "PAY NOW"
                      .text
                      .center
                      .semiBold
                      .coolGray600
                      .size(16)
                      .makeCentered(),
                ),
              ),
            ),
            // SizedBox(
            //   height: 88.h,
            //   child: ListView.builder(
            //     //physics: NeverScrollableScrollPhysics(),
            //       scrollDirection: Axis.vertical,
            //       itemCount:1,
            //       itemBuilder: (BuildContext context,int index){
            //         return AllPayment_class('ABCD','Price',Icons.arrow_forward_ios,(){
            //
            //           // showModalBottomSheet(
            //           //     context: context,
            //           //     backgroundColor: Colors.transparent,
            //           //     builder: (context) {
            //           //       return bookBottomSheet(context);
            //           //     });
            //
            //         },(){
            //           // showModalBottomSheet(
            //           //     context: context,
            //           //     backgroundColor: Colors.transparent,
            //           //     builder: (context) {
            //           //       return bookBottomSheet(context);
            //           //     });
            //
            //         } ,(){
            //           // showModalBottomSheet(
            //           //     context: context,
            //           //     backgroundColor: Colors.transparent,
            //           //     builder: (context) {
            //           //       return bookBottomSheet(context);
            //           //     });
            //
            //
            //         });
            //       }
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget AllPayment_class(package, paylater, paynow, ontap, ontap1, ontap2) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        13.h.heightBox,
        Container(
          height: 50.h,
          width: 92.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 10.h,
                  width: 42.5.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.h),
                    color: Colors.deepOrange,
                  ),
                  child: 'PREMIUM'.text.semiBold.white.size(20).makeCentered(),
                ).onTap(ontap),

                3.h.heightBox,
                Container(
                  height: 10.h,
                  width: 42.5.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.h),
                    color: Colors.lightBlue,
                  ),
                  child: 'GOLD'.text.semiBold.white.size(20).makeCentered(),
                ).onTap(ontap1),

                3.h.heightBox,
                Container(
                  height: 10.h,
                  width: 42.5.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.h),
                    color: Colors.green,
                  ),
                  child: 'FREE'.text.semiBold.white.size(20).makeCentered(),
                ).onTap(ontap2),

                // '$package'.text.gray600.size(12).overflow(TextOverflow.clip).make().objectCenterLeft(),
                // '$paylater'.text.semiBold.red500.size(15).make().objectCenterLeft(),
                // '$paynow'.text.semiBold.red500.size(15).make().objectCenterLeft(),
              ],
            ),
          ),
        ),
        // 2.h.heightBox,
      ],
    ),
  );
}
