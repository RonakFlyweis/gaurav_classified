import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/models/name_image_model.dart';
import 'package:sn_2nd/screen/sign_up/model/signup_model.dart';

class ApiProvider {
  // -------------------------------------------Webservice Url--------------------------------------------------------------
  //static String baseUrl = "http://vigyapn.com:5000";
  static String baseUrl =
      "https://classifide-9090.herokuapp.com"; //todo change base Url
  // ------------------------------------------------------------------------------------------------------------------

  //for SignUp user
  static Future registerUser(var name, var email, var pass, var mobile) async {
    var headers = {'Content-Type': 'application/json'};

    var body = json.encode(
        {"username": name, "email": email, "password": pass, "phone": mobile});

    var url = baseUrl + "/register";

    var r = await post(Uri.parse(url), body: body, headers: headers);
    print(r.body);
    return r;
  }

  // for Login Usre
  static Future loginUser(var email, var pass) async {
    var headers = {'Content-Type': 'application/json'};

    var body = json.encode({"email": email, "password": pass});

    var url = baseUrl + "/login";

    var r = await post(Uri.parse(url), body: body, headers: headers);
    print(r.body);

    return r;
  }

  // get list of featured ads
  static Future getFeaturedAds() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/ads/featured";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return r;
  }

  // get all Category
  static Future getAllCategory() async {
    var url = baseUrl + "/getCategory";

    var r = await get(Uri.parse(url));
    print(r.body);

    return r;
  }

  // get all Sub-Category
  static Future getAllSubCategory() async {
    var url = baseUrl + "/getSubCategory";
    var r = await get(Uri.parse(url));
    print(r.body);
    return r;
  }

  // get all Sub-Category-by-id
  static Future getAllSubCategoryById(String id) async {
    var url = baseUrl + "/getSubCategoryByCategoryId/$id";
    var r = await get(Uri.parse(url));
    print(r.body);
    return r;
  }

  // get list of featured ads
  static Future getFavoriteAds() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/getLikedAds";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return jsonDecode(r.body);
  }

  // get list of pending ads
  static Future getPendingAds() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/pendingAds";

    var r = await get(Uri.parse(url), headers: headers);
    print('pending ads');
    print(r.request);
    print(r.body);
    print(jsonDecode(r.body).length);
    return jsonDecode(r.body);
  }

  // get list of Hidden ads
  static Future getHiddenAds() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/getHiddenAds";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return r;
  }

  // get list of My ads
  static Future getMyAds() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/myAds";

    Response r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return r;
  }

  static Future getMyAdsBody() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/myAds";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return jsonDecode(r.body);
  }

  // get list of Resubmited ads
  static Future getResubmitAds() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/ads/resubmitted";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.request);
    print(r.statusCode);
    print(r.body);

    return r;
  }

  // get list of Expired ads
  static Future getExpiredtAds() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/getExpiryAds";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return r;
  }

  // setting API
  static Future changePassword(String currentPass, String newPass) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Constants.token}',
    };
    var url = 'https://classifide-9090.herokuapp.com/update/password/user';
    var body = jsonEncode({
      "currentPassword": currentPass,
      "newPassword": newPass
    });
    Response response = await post(Uri.parse(url), headers: headers, body: body);
    return response;
  }

  // get profile data
  static Future getProfileData() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/loggedUserDetail";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return r;
  }

  // get list of published ads
  static Future getPublishedtAds() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/ads/published";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return r;
  }

  // forget password
  static Future forgetPassword(var email) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({"email": email});

    var url = baseUrl + "/email-send";

    var r = await post(Uri.parse(url), headers: headers, body: body);
    print(r.body);

    return r;
  }

  // Reset forget password
  static Future resetForgetPassword(var otp, var pass, var email) async {
    var headers = {'Content-Type': 'application/json'};
    var body = json.encode({
      'email': email,
      'code': otp,
      "password": pass,
    });

    var url = baseUrl + "/change-password";

    var r = await post(Uri.parse(url), headers: headers, body: body);
    print(r.body);

    return r;
  }

  // Edit Profile
  static Future editProfile(var name, var about, var phone, var email, var web,
      var address, var fb, var insta, var img, bool isImageChanged) async {
    var headers = {
      //'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Constants.token}'
    };
    var url = baseUrl + "/editUser";
    var request = MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      //'username': 'prince',
      'email': email,
      'phone': phone,
      'aboutUs': about,
      'address': address,
      'name': name,
      'website': web,
      'facebook': fb,
      'instagram': insta,
      //'newPassword': '78787878'
    });
    print(img);
    if (isImageChanged) {
      request.files.add(await MultipartFile.fromPath('myField', img));
    }
    request.headers.addAll(headers);
    var res = await request.send();

    Response r = await Response.fromStream(res);
    print(r.body);
    return r;
  }

  // add post api
  static Future addPost(
    String cat,
    String subcat,
    String title,
    String des,
    dynamic img,
    String adType,
    String price,
    String nego,
    String mob,
    String loc,
    String tag,
  ) async {
    print('adding post');
    var headers = {'Authorization': 'Bearer ${Constants.token}'};
    var url = baseUrl + "/addAd";
    var request = MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'title': title,
      'description': des,
      'category': cat,
      'subCategory': subcat,
      'adType': adType,
      'price': price,
      'negotitate': nego,
      'mobileNumber': mob,
      'location': loc,
      'tag': tag
    });
    for (int i = 0; i < img.length; i++) {
      print('adding image');
      request.files.add(await MultipartFile.fromPath('myField', img[i].path));
    }
    // request.files.add(await MultipartFile.fromPath('myField', img.path));
    request.headers.addAll(headers);
    var res = await request.send();
    Response r = await Response.fromStream(res);
    print('here');
    print(r.body);
    return r;
  }

  // get Package
  static Future getAllPackage() async {
    var headers = {'Content-Type': 'application/json'};

    var url = baseUrl + "/getPackage";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return r;
  }

  // get all ads All Ads
  static Future getAllAds() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/getAllAds";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return r;
  }

  static Future getAllAdsUnauthenticated() async {

    var url = baseUrl + "/getAdDetail";

    var r = await get(Uri.parse(url));
    print(r.body);

    return r;
  }

  // add likes
  static Future addLikes(var id) async {
    var headers = {
      'Authorization': 'Bearer ${Constants.token}',
      'Content-Type': 'application/json'
    };
    var body = json.encode({"addId": id});
    var url = baseUrl + "/likeAd";

    var r = await post(Uri.parse(url), headers: headers, body: body);
    print(r.body);

    return r;
  }

  // get user details
  static Future getUserDetails() async {
    var headers = {'Authorization': 'Bearer ${Constants.token}'};

    var url = baseUrl + "/loggedUserDetail";

    var r = await get(Uri.parse(url), headers: headers);
    print(r.body);

    return r;
  }

  static Future getIndividualUserByUserId(String userId) async {
    var url = baseUrl + "/find/userbyid/" + userId;
    print(url);
    try {
      var r = await get(Uri.parse(url));
      if (r.statusCode == 200) {
        print(r.body);
        return nameImageModelFromJson(r.body);
      } else {
        return Future.error(r.reasonPhrase!);
      }
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
  }
}
