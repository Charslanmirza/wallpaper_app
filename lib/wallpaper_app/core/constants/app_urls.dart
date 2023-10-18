import 'package:get/get.dart';

class AppUrls {
  // URLS
  // "dis2";
  //   "dis";
  //     "dis-customerdev";
  // static final debugUrl = Get.find<ClientAuth>().serverUrl
  //
  // // "http://47.241.123.74:8044"
  //     ;

  static const privacyPolicyUrl = 'https://dis-aircon.com.sg/privacy-policy';

  static final baseUrl = 'https://api.pexels.com/v1';

  // "https://dis2.staging.knkit.com/";
  // "http://dis.devumar.knkit.com/";
  // "http://dis-customerdev.knkit.com/";

  static final testUrl = "${baseUrl}rest";
  static final apiKey = "XCBTcyr9IhYCYm8j4EaNkTUMAQ95xffpwG3yGt3rsYIS80ktAJTS30UW";

  static const brandsUrl = '/get_brands/';
  static const categoriesUrl = '/get_category/';

  static imageUrl(String model, int id) =>
      "${baseUrl}web/image?model=$model&id=$id&field=image_1920";
}
