import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/models/all_categories_model.dart';
import 'package:sn_2nd/models/sub_categories_model.dart';
import 'package:sn_2nd/screen/category_page/model/category_model.dart';
import 'package:sn_2nd/screen/post_ads/model/feature_model.dart';
import 'package:sn_2nd/screen/post_ads/model/package_model.dart';
import 'package:sn_2nd/screen/post_ads/payment_part.dart';

import 'package:sn_2nd/screen/post_ads/widget/derop_box.dart';
import 'package:sn_2nd/screen/post_ads/widget/feature_list.dart';
import 'package:sn_2nd/screen/post_ads/widget/payment_bottom_sheet.dart';
import 'package:sn_2nd/screen/post_ads/widget/text_dield_box.dart';
import 'package:sn_2nd/screen/sub_category_page/model/subcategory_model.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../constant.dart';

class PostFreeAds extends StatefulWidget {
  const PostFreeAds({Key? key}) : super(key: key);

  @override
  State<PostFreeAds> createState() => _PostFreeAdsState();
}

class _PostFreeAdsState extends State<PostFreeAds> {
  bool Negotiate = false;
  bool ad = true;
  String adText = 'Free Ad';
  String adType = 'Private';
  List<AllCategorymodel> catData = [];
  List<SubCategorymodel> subcat = [];
  bool trans = true;
  String transmission = 'Automatic';
  bool type = true;
  List<XFile> imageFileList = [];
  AllCategorymodel? _chosenCat;
  String chosenState = 'Andaman and Nicobar Islands';
  SubCategorymodel? _chosenSubCat;
  TextEditingController _description = TextEditingController();
  File _image = File("");
  TextEditingController _location = TextEditingController();
  TextEditingController _mobile = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _tag = TextEditingController();
  TextEditingController _title = TextEditingController();
  List<PackageModel> pkgData = [];
  @override
  void initState() {
    super.initState();
    getCatdata();
  }

  _getPackage() async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.getAllPackage();
    print('following is the body');
    print(r.body);
    EasyLoading.dismiss();
    List<PackageModel> data = packageModelFromJson(r.body);
    pkgData = data;
  }

  getSubCat(var id) async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.getAllSubCategoryById(_chosenCat!.id!);

    if (r.statusCode == 200) {
      List<SubCategorymodel> data = subCategorymodelFromJson(r.body);
      subcat = data;
    }
    EasyLoading.dismiss();
    setState(() {});
  }

  getCatdata() async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.getAllCategory();

    if (r.statusCode == 200) {
      List<AllCategorymodel> data = allCategorymodelFromJson(r.body);
      catData = data;
    }
    EasyLoading.dismiss();
    setState(() {});
  }

  void _pickImage(ImageSource imageSource) async {
    final picker = ImagePicker();
    //TODO made 1st change here
    final pickedFile = await picker.pickImage(source: imageSource);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //TODO creating a new function to pick multiple images

  void _pickMultipleImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage();
    print('here');
    setState(() {
      if (selectedImages!.isNotEmpty) {
        imageFileList.addAll(selectedImages);
        print("added");
      } else {
        print('No Images Selected ');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              1.h.heightBox,
              Row(
                children: [
                  Icon(
                    Icons.arrow_back_outlined,
                    size: 25.sp,
                  ).onTap(() {
                    Navigator.pop(context);
                  }),
                  2.w.widthBox,
                  'Post Free Ads'.text.bold.size(20.sp).letterSpacing(1).make(),
                ],
              ),
              2.h.heightBox,
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Ads Details'.text.size(18.sp).bold.gray400.make(),
                        4.h.heightBox,
                        'Categories'.text.size(18.sp).make(),
                        catData.isEmpty
                            ? dropDownBox('Select Categories')
                            : Container(
                                width: double.infinity,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  //color: Colors.red,
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 2, color: Colors.grey.shade400),
                                  ),
                                ),
                                child: DropdownButton<AllCategorymodel>(
                                  value: _chosenCat,
                                  underline: SizedBox(),
                                  elevation: 0,
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    size: 3.5.h,
                                  ),
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.black),
                                  items: catData.map((e) {
                                    return DropdownMenuItem<AllCategorymodel>(
                                      child: Text('${e.name}'),
                                      value: e,
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "Choose Category*",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      subcat = [];

                                      _chosenCat = value!;
                                      print(_chosenCat);
                                      getSubCat(value.id);
                                    });
                                  },
                                ),
                              ),
                        3.h.heightBox,
                        'Sub Categories'.text.size(18.sp).make(),
                        subcat.isEmpty
                            ? dropDownBox('Select Sub-categories')
                            : Container(
                                width: double.infinity,
                                height: 6.h,
                                decoration: BoxDecoration(
                                  //color: Colors.red,
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 2, color: Colors.grey.shade400),
                                  ),
                                ),
                                child: DropdownButton<SubCategorymodel>(
                                  value: _chosenSubCat,
                                  underline: SizedBox(),
                                  elevation: 0,
                                  isExpanded: true,
                                  icon: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    size: 3.5.h,
                                  ),
                                  style: TextStyle(
                                      fontSize: 14.sp, color: Colors.black),
                                  items: subcat.map((e) {
                                    return DropdownMenuItem<SubCategorymodel>(
                                      child: Text('${e.name}'),
                                      value: e,
                                    );
                                  }).toList(),
                                  hint: Text(
                                    "Choose Sub-Category*",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      _chosenSubCat = value!;
                                      print(_chosenSubCat);
                                    });
                                  },
                                ),
                              ),
                        3.h.heightBox,
                        'Ad Title'.text.size(18.sp).make(),
                        textFieldBox('Title for your Advertise', _title),
                        3.h.heightBox,
                        'Description'.text.size(18.sp).make(),
                        textFieldBox(
                            'Tell Us more about your advertise', _description),
                        2.h.heightBox,
                        //TODO adding multi images grid
                        // Container(
                        //   width: double.infinity,
                        //   height: 15.h,
                        //   alignment: Alignment.center,
                        //   child: Container(
                        //     width: 30.w,
                        //     height: 15.h,
                        //     decoration: BoxDecoration(
                        //         border:
                        //             Border.all(width: 1, color: Colors.black)),
                        //     child: _image.path == ''
                        //         ? Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Icon(
                        //                 Icons.add_a_photo,
                        //                 size: 40.sp,
                        //                 color: Colors.blue,
                        //               ),
                        //               'Add Photo'
                        //                   .text
                        //                   .size(14.sp)
                        //                   .gray500
                        //                   .make(),
                        //             ],
                        //           )
                        //         : Image.file(
                        //             _image,
                        //             fit: BoxFit.cover,
                        //           ),
                        //   ).onTap(() {
                        //     _pickImage(ImageSource.gallery);
                        //   }),
                        // ),

                        SizedBox(
                          height: 15.h,
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              // setState(() {
                              _pickMultipleImage(ImageSource.gallery);
                              // });
                            },
                            child: GridView.builder(
                                itemCount: imageFileList.isEmpty
                                    ? 1
                                    : imageFileList.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4),
                                itemBuilder: (context, index) => Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.5))),
                                    child: imageFileList.isEmpty
                                        ? Icon(
                                            CupertinoIcons.camera,
                                            color: Colors.grey.withOpacity(0.5),
                                          )
                                        : Image.file(
                                            File(imageFileList[index].path),
                                            fit: BoxFit.cover,
                                          ))),
                          ),
                        ),
                        2.h.heightBox,
                        'Ad Type'.text.size(18.sp).letterSpacing(1).bold.make(),
                        2.h.heightBox,
                        Container(
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 3.h,
                                    width: 10.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            type ? Colors.blue : Colors.white,
                                        border: Border.all(width: 1)),
                                  ).onTap(() {
                                    setState(() {
                                      type = true;
                                      adType = 'Private';
                                    });
                                    print(adType);
                                  }),
                                  'Private'.text.size(16.sp).make(),
                                ],
                              ),
                              10.w.widthBox,
                              Row(
                                children: [
                                  Container(
                                    height: 3.h,
                                    width: 10.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            type ? Colors.white : Colors.blue,
                                        border: Border.all(width: 1)),
                                  ).onTap(() {
                                    setState(() {
                                      type = false;
                                      adType = 'Professional';
                                    });
                                    print(adType);
                                  }),
                                  'Professional'.text.size(16.sp).make(),
                                ],
                              )
                            ],
                          ),
                        ),

                        3.h.heightBox,
                        'Price'.text.size(18.sp).make(),
                        2.h.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 7.h,
                              width: 40.w,
                              padding: EdgeInsets.all(5.sp),
                              decoration: BoxDecoration(
                                  border: Border.all(width: 1),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              child: TextField(
                                controller: _price,
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 14.sp),
                                decoration: InputDecoration(
                                  hintText: 'Price',
                                  border: InputBorder.none,
                                  suffix: '₹'.text.size(14.sp).make(),
                                ),
                              ),
                            ),
                            featureList('Negotiate', Negotiate).onTap(() {
                              setState(() {
                                Negotiate
                                    ? Negotiate = false
                                    : Negotiate = true;
                              });
                            }),
                          ],
                        ),
                        3.h.heightBox,
                        'Contact Information'.text.gray500.size(16.sp).make(),
                        3.h.heightBox,
                        'Mobile Number'.text.size(16.sp).make(),
                        textFieldBoxNum('0123456789', _mobile),
                        3.h.heightBox,
                        //'Location'.text.size(16.sp).make(),
                        'Location'.text.size(18.sp).make(),
                        Container(
                          width: double.infinity,
                          height: 6.h,
                          decoration: BoxDecoration(
                            //color: Colors.red,
                            border: Border(
                              bottom: BorderSide(
                                  width: 2, color: Colors.grey.shade400),
                            ),
                          ),
                          child: DropdownButton<String>(
                            value: chosenState,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style:
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                            onChanged: (String? newValue) {
                              setState(() {
                                chosenState = newValue!;
                              });
                            },
                            items: states
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                        // states.isEmpty
                        //     ? dropDownBox('Select Categories')
                        //     :
                        // Container(
                        //   width: double.infinity,
                        //   height: 6.h,
                        //   decoration: BoxDecoration(
                        //     //color: Colors.red,
                        //     border: Border(
                        //       bottom: BorderSide(
                        //           width: 2, color: Colors.grey.shade400),
                        //     ),
                        //   ),
                        //   child: DropdownButton<String>(
                        //     value: chosenState,
                        //     underline: SizedBox(),
                        //     elevation: 0,
                        //     isExpanded: true,
                        //     icon: Icon(
                        //       Icons.arrow_drop_down_circle_outlined,
                        //       size: 3.5.h,
                        //     ),
                        //     style:
                        //         TextStyle(fontSize: 14.sp, color: Colors.black),
                        //     items: states
                        //         .map<DropdownMenuItem<String>>((String value) {
                        //       return DropdownMenuItem<String>(
                        //         value: value,
                        //         child: Text(value),
                        //       );
                        //     }).toList(),
                        //     // hint: Text(
                        //     //   "State",
                        //     //   style: TextStyle(
                        //     //     color: Colors.black,
                        //     //     fontSize: 14.sp,
                        //     //   ),
                        //     // ),
                        //     onChanged: (value) {
                        //       setState(() {
                        //         chosenState = value!;
                        //       });
                        //     },
                        //   ),
                        // ),

                        // 2.h.heightBox,
                        // textFieldBox('location', _location),
                        2.h.heightBox,
                        'Tag'.text.size(16.sp).make(),
                        textFieldBox('Enter tag separated by comma', _tag),
                        2.h.heightBox,
                        'Make Your Ad Premium (Optional)'
                            .text
                            .size(14.sp)
                            .make(),
                        2.h.heightBox,
                        Row(
                          children: [
                            Container(
                              height: 3.h,
                              width: 5.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ad ? Colors.blue : Colors.white,
                                border: Border.all(width: 1),
                              ),
                            ),
                            4.w.widthBox,
                            'Free Ad'.text.size(12.sp).make(),
                          ],
                        ).onTap(() {
                          setState(() {
                            ad ? ad = false : ad = true;
                            adText = 'Free Ad';
                          });
                          print(adText);
                        }),
                        1.h.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 3.h,
                                  width: 5.w,
                                  decoration: BoxDecoration(
                                    color: ad ? Colors.white : Colors.blue,
                                    shape: BoxShape.circle,
                                    border: Border.all(width: 1),
                                  ),
                                ),
                                4.w.widthBox,
                                'Premium'.text.size(12.sp).make(),
                              ],
                            ).onTap(() {
                              setState(() {
                                ad ? ad = false : ad = true;
                                adText = 'Premium';
                              });
                              print(adText);
                            }),
                            Container(
                              height: 2.5.h,
                              width: 26.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(color: Colors.blue),
                              child: 'Recommended'
                                  .text
                                  .size(10.sp)
                                  .color(Colors.white)
                                  .make(),
                            ),
                          ],
                        ),
                        2.h.heightBox,

                        //PaymentPart
                        Container(
                          width: 35.w,
                          height: 7.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(width: 5, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10.sp),
                            color: Colors.blue[900],
                          ),
                          child: 'Post Ad'
                              .text
                              .size(20.sp)
                              .color(Colors.white)
                              .make(),
                        ).centered().onTap(() async {
                          if (_chosenCat != null &&
                                  _title.text.isNotEmpty &&
                                  _description.text.isNotEmpty &&
                                  // _image != File("") &&
                                  imageFileList.isNotEmpty &&
                                  adType != '' &&
                                  _price.text.isNotEmpty &&
                                  _mobile.text.isNotEmpty &&
                                  // _location.text.isNotEmpty &&
                                  chosenState.isNotEmpty &&
                                  _tag.text.isNotEmpty
                              //&& _chosenSubCat != null
                              ) {
                            if (adText == 'Premium') {
                              //await _getPackage();
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return PaymentBottomSheet(
                                    pkgdata: pkgData,
                                    chosenCat: _chosenCat!,
                                    title: _title,
                                    description: _description,
                                    imageFileList: imageFileList,
                                    adType: adType,
                                    price: _price,
                                    Negotiate: Negotiate,
                                    mobile: _mobile,
                                    chosenState: chosenState,
                                    tag: _tag,

                                  );
                                },
                              );
                              // Navigator.push(
                              //     context,
                              //      MaterialPageRoute( builder: (context) => PaymentPart()));
                            } else if (adText == 'Free Ad') {
                              EasyLoading.show(
                                  status: 'Loading...', dismissOnTap: false);
                              Response r = await ApiProvider.addPost(
                                  _chosenCat!.name!,
                                  'sub category',
                                  _title.text,
                                  _description.text,
                                  imageFileList,
                                  adType,
                                  _price.text,
                                  Negotiate ? 'Yes' : 'No',
                                  _mobile.text,
                                  // _location.text,
                                  chosenState,
                                  //chosenState,
                                  _tag.text);
                              EasyLoading.dismiss();
                              print('here');
                              print(r.statusCode);
                              if (r.statusCode >= 200 && r.statusCode <= 210) {
                                EasyLoading.showSuccess(
                                    'Ad added successfully');
                                Navigator.of(context).pop();
                              }
                            }
                          } else {
                            EasyLoading.showToast('Enter Data');
                          }
                        }),
                        5.h.heightBox,
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
