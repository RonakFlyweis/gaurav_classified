import 'package:sizer/sizer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: 'PAY NOW'.text.center.bold.size(18).make(),
        centerTitle: true,
      ),
      body: Column(

        children: [
          5.h.heightBox,
          Center(
            child: Container(
              child: Image.asset('assets/image/qr_code_scanner.jpg'),
              

            ),
          ),
          3.h.heightBox,
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
                              width: 1, color: Colors.purple, style: BorderStyle.solid)),
                      child: 'Scane & Pay'.text.bold.center.size(19).make().pOnly(top: 0.5.h),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
