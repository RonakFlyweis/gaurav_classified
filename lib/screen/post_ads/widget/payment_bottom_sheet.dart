import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_2nd/screen/home_page/home_page.dart';
import 'package:sn_2nd/screen/post_ads/model/package_model.dart';
import 'package:sn_2nd/screen/post_ads/widget/derop_box.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../models/all_categories_model.dart';

class PaymentBottomSheet extends StatefulWidget {
  List<PackageModel> pkgdata;
  AllCategorymodel chosenCat;
  TextEditingController title;
  TextEditingController description;
  List<XFile> imageFileList;
  String adType;
  TextEditingController price;
  TextEditingController mobile;
  String chosenState;
  TextEditingController tag;
  bool Negotiate;

  PaymentBottomSheet(
      {Key? key,
      required this.pkgdata,
      required this.chosenCat,
      required this.title,
      required this.description,
      required this.imageFileList,
      required this.adType,
      required this.price,
      required this.mobile,
      required this.chosenState,
      required this.tag,
      required this.Negotiate})
      : super(key: key);

  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(/*PackageModel packageModel*/) async {
    print('opened Checkout');
    var options = {
      'key': 'rzp_live_vLCwa4Sodvp6mc',
      'amount': 100,
      //'amount': packageModel.price,
      'name': 'Vigyapan',
      'description': 'Ad Premium Package',
      'retry': {'enabled': true, 'maxCount': 1},
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      //print('trying');
      _razorpay.open(options);
    } catch (e) {
      // print('catched part executed');
      print('Error : ' + e.toString());
    }
  }

  List<String> pkg = ['A', 'B', 'C', 'D', 'E'];
  String? select;
  // List<PackageModel> pkgData = [];
  PackageModel? package;
  String start = '', end = '', price = '1.0';

  DateTime startDate = DateTime.now(), endDate = DateTime.now();

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    EasyLoading.showSuccess('Success: ' + response.paymentId!,
        maskType: EasyLoadingMaskType.black);
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.addPost(
        widget.chosenCat.name!,
        'sub category',
        widget.title.text,
        widget.description.text,
        widget.imageFileList,
        widget.adType,
        widget.price.text,
        widget.Negotiate ? 'Yes' : 'No',
        widget.mobile.text,
        // _location.text,
        widget.chosenState,
        //chosenState,
        widget.tag.text);
    EasyLoading.dismiss();
    if (r.statusCode >= 200 && r.statusCode <= 210) {
      EasyLoading.showSuccess('Ad added successfully');
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      EasyLoading.showSuccess(
          'Some error occured your payment would be refunded');
      Navigator.of(context).pop();
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    EasyLoading.showError(
        'Error: ' + response.code.toString() + ' - ' + response.message!,
        maskType: EasyLoadingMaskType.black);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    EasyLoading.showToast('External_Wallet: ' + response.walletName!,
        maskType: EasyLoadingMaskType.black);
  }

  @override
  Widget build(BuildContext context) {
    // pkgData = widget.pkgdata;

    start = DateFormat('dd-mm-yyyy').format(startDate);
    end = DateFormat('dd-mm-yyyy').format(endDate);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.sp),
          topRight: Radius.circular(15.sp),
        ),
        color: Vx.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            2.h.heightBox,
            RichText(
              text: TextSpan(
                text: 'CHOOSE ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 18.sp),
                children: <TextSpan>[
                  TextSpan(
                      text: 'PACKAGES',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18.sp)),
                  // TextSpan(
                  //     text: '',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
            ),
            5.h.heightBox,
            widget.pkgdata.isEmpty
                ? dropDownBox('Select Package')
                : Container(
                    width: double.infinity,
                    height: 8.h,
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.grey.shade500),
                    ),
                    child: DropdownButton<PackageModel>(
                      value: package,
                      underline: SizedBox(),
                      elevation: 0,
                      isExpanded: true,
                      icon: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        size: 3.5.h,
                      ),
                      style: TextStyle(fontSize: 14.sp, color: Colors.black),
                      items: widget.pkgdata.map((e) {
                        return DropdownMenuItem<PackageModel>(
                          child: Text('${e.id}'),
                          value: e,
                        );
                      }).toList(),
                      hint: Text(
                        "Choose Package*",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      onChanged: (value) {
                        setState(() {
                          package = value!;
                          startDate = package!.startDate!;
                          endDate = package!.endDate!;
                          price = package!.price!;
                          print(select);
                        });
                      },
                    ),
                  ),
            3.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Start Date : '.text.size(16.sp).bold.make(),
                '$start'.text.size(16.sp).make(),
              ],
            ),
            3.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'End Date : '.text.size(16.sp).bold.make(),
                '$end'.text.size(16.sp).make(),
              ],
            ),
            3.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Price : '.text.size(16.sp).bold.make(),
                '$price'.text.size(16.sp).make(),
              ],
            ),
            5.h.heightBox,
            InkWell(
              onTap: () {
                // if (package != null) {
                openCheckout();
                // } else {
                //   EasyLoading.showToast('Select Package');
                // }
              },
              child: Container(
                height: 6.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: Vx.blue500,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.black26,
                      spreadRadius: 5,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: 'PAY NOW'.text.white.bold.size(15.sp).make().centered(),
              ),
            ),
            4.h.heightBox,
          ],
        ),
      ),
    );
  }
}
