import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_2nd/models/sub_categories_model.dart';
import 'package:sn_2nd/screen/home_page/home_page.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../models/all_categories_model.dart';

class PaymentBottomSheet extends StatefulWidget {
  dynamic package;
  AllCategorymodel chosenCat;
  SubCategorymodel subCategory;
  TextEditingController title;
  TextEditingController description;
  List<XFile> imageFileList;
  String adType;
  TextEditingController price;
  TextEditingController mobile;
  String chosenState;
  String chosenDistrict;
  TextEditingController tag;
  bool Negotiate;

  PaymentBottomSheet(
      {Key? key,
      required this.package,
      required this.chosenCat,
      required this.subCategory,
      required this.title,
      required this.description,
      required this.imageFileList,
      required this.adType,
      required this.price,
      required this.mobile,
      required this.chosenState,
      required this.chosenDistrict,
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
    addPackage();
    selectedPackage = widget.package[0]["title"];
    print(packages);
    print(selectedPackage);
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

  addPackage() {
    for (int i = 0; i < widget.package.length; i++) {
      packages.add(widget.package[i]["title"]);
      dynamic info = {
        "${widget.package[i]["title"]}": {
          "start": "${widget.package[i]["start_date"]}",
          "end": "${widget.package[i]["end_date"]}",
          "price": "${widget.package[i]["price"]}"
        },
      };
      packageInfo.addAll(info);
    }
    startDate = packageInfo[widget.package[0]["title"]]["start"];
    endDate = packageInfo[widget.package[0]["title"]]["end"];
    price = packageInfo[widget.package[0]["title"]]["price"];
  }

  void openCheckout() async {
    print('opened Checkout');
    var options = {
      'key': 'rzp_live_vLCwa4Sodvp6mc',
      'amount': int.parse(price) * 100,
      'name': 'Vigyapan',
      'description': 'Ad Premium Package',
      'retry': {'enabled': true, 'maxCount': 1},
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Error : ' + e.toString());
    }
  }

  List<String> packages = <String>[];
  Map<dynamic, dynamic> packageInfo = {};
  late String startDate;
  late String endDate;
  late String price;
  late String selectedPackage;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    EasyLoading.showSuccess('Success: ' + response.paymentId!,
        maskType: EasyLoadingMaskType.black);
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.addPost(
        widget.chosenCat.name!,
        widget.subCategory.name ?? "sub category",
        widget.title.text,
        widget.description.text,
        widget.imageFileList,
        widget.adType,
        widget.price.text,
        widget.Negotiate ? 'Yes' : 'No',
        widget.mobile.text,
        widget.chosenState + " " + widget.chosenDistrict,
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
                ],
              ),
            ),
            5.h.heightBox,
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPackage = newValue!;
                      startDate = packageInfo[selectedPackage]["start"];
                      endDate = packageInfo[selectedPackage]["end"];
                      price = packageInfo[selectedPackage]["price"];
                    });
                  },
                  value: selectedPackage,
                  isExpanded: true,
                  items: packages.map<DropdownMenuItem<String>>((String Value) {
                    return DropdownMenuItem<String>(
                      value: Value,
                      child: Center(
                          child: Text(
                        Value,
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                      )),
                    );
                  }).toList(),
                ),
              ),
            ),
            3.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Start Date : '.text.size(16.sp).bold.make(),
                startDate.text.size(16.sp).make(),
              ],
            ),
            3.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'End Date : '.text.size(16.sp).bold.make(),
                endDate.text.size(16.sp).make(),
              ],
            ),
            3.h.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Price : '.text.size(16.sp).bold.make(),
                price.text.size(16.sp).make(),
              ],
            ),
            5.h.heightBox,
            InkWell(
              onTap: () {
                openCheckout();
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
