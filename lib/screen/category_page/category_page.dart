import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:sn_2nd/models/all_categories_model.dart';
import 'package:sn_2nd/screen/category_page/model/category_model.dart';
import 'package:sn_2nd/screen/category_page/widget/cat_item.dart';
import 'package:sn_2nd/screen/category_page/widget/cat_line.dart';
import 'package:sn_2nd/screen/sub_category_page/show_sub_categries.dart';
import 'package:sn_2nd/web_services/api_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:sizer/sizer.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<AllCategorymodel> catData = [];

  @override
  void initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    EasyLoading.show(status: 'Loading...', dismissOnTap: false);
    Response r = await ApiProvider.getAllCategory();
    if (r.statusCode == 200) {
      catData = allCategorymodelFromJson(r.body);
    }
    EasyLoading.dismiss();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              3.h.heightBox,
              Row(
                children: [
                  4.w.widthBox,
                  Icon(
                    Icons.arrow_back_outlined,
                    size: 25.sp,
                  ).onTap(() {
                    Navigator.pop(context);
                  }),
                  2.w.widthBox,
                  'Categories'.text.bold.size(20.sp).letterSpacing(1).make(),
                ],
              ),
              5.h.heightBox,
              catLine(),
              Expanded(
                child: ListView.builder(
                  itemCount: catData.length,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        catItem(catData[i].name!).onTap(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowSubCategories(
                                        cat: catData[i],
                                      )));
                        }),
                        catLine(),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
