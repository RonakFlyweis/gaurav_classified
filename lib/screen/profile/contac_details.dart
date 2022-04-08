import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';

class ContactUs extends StatefulWidget {

  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: 'ABOUT US'.text.bold.center.center.semiBold.size(19).make(),
        centerTitle: true,



      ),



      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              3.h.heightBox,

              Container(
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 60.h,
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            contact_builder('assets/icon/phone.png', 'Address', 'Vigyapn.com , RZF-757/28, \nDWARKA SECTOR8, NEW DELHI-110077'.toUpperCase()),
                            contact_builder('assets/icon/phone.png', 'Contact', '+918882822295'),
                            contact_builder('assets/icon/phone.png', 'Mail', 'vigyapn@gmail.com'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget contact_builder(img,title,subtext){
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(img),
            3.w.widthBox,
            '$title'.text.blue700.size(20).semiBold.make(),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(width: 20,),
            '$subtext'.text.black.wide.overflow(TextOverflow.clip).size(15).make(),
          ],
        ),
      )
    ],
  );
}
