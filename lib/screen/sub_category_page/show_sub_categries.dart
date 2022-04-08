import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'package:sn_2nd/models/all_categories_model.dart';
import 'package:sn_2nd/models/sub_categories_model.dart';
import 'package:sn_2nd/screen/category_page/model/category_model.dart';

import 'package:sn_2nd/screen/sub_category_page/model/subcategory_model.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ShowSubCategories extends StatefulWidget {
  AllCategorymodel cat;
  ShowSubCategories({required this.cat});
  @override
  State<ShowSubCategories> createState() => _ShowSubCategoriesState();
}

class _ShowSubCategoriesState extends State<ShowSubCategories> {
  List<SubCategorymodel> subcat = [];
  @override
  void initState() {
    super.initState();
    _getdata();
  }

  _getdata() async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.getAllSubCategory();

    if (r.statusCode == 200) {
      subcat = subCategorymodelFromJson(r.body);
    }
    EasyLoading.dismiss();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          children: [
            3.h.heightBox,
            Row(
              children: [
                Icon(
                  Icons.arrow_back_outlined,
                  size: 25.sp,
                ).onTap(() {
                  Navigator.pop(context);
                }),
                2.w.widthBox,
                widget.cat.name!.text.bold
                    .size(18.sp)
                    .bold
                    .letterSpacing(1)
                    .make(),
              ],
            ),
            6.h.heightBox,
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 25.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  'All Sub Categries'.text.size(20.sp).make(),
                  2.h.heightBox,
                  Expanded(
                    child: ListView.builder(
                      itemCount: subcat.length,
                      itemBuilder: (context, i) {
                        print(subcat[i].id);
                        print(widget.cat.id);
                        if (subcat[i].parentCategory == widget.cat.id) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            child: '${subcat[i].name}'.text.size(16.sp).make(),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      )),
    );
  }
}
