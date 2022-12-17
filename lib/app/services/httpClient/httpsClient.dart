import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HttpsClient {
  static String domain = 'http://81.68.248.232:3000';

  static Dio dio = Dio();

  HttpsClient() {
    dio.options.baseUrl = domain;

    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..dismissOnTap = false
      ..userInteractions = true
      ..indicatorType = EasyLoadingIndicatorType.wave;
  }

  Future get(apiUrl,
      {Map<String, dynamic>? params, bool? cache = false}) async {
    try {
      if (!cache!) {
        var response = await dio.get(
            '$apiUrl?_t=${DateTime.now().millisecondsSinceEpoch}',
            queryParameters: params);
        return response;
      }
      var response = await dio.get('$apiUrl', queryParameters: params);
      return response;
    } catch (err) {
      print("请求超时");
      EasyLoading.showToast('网络似乎出问题了');
      return null;
    }
  }

  Future post(apiUrl, {Map<String, dynamic>? params}) async {
    try {
      var response = await dio.post(apiUrl,
          data: {...params!, '_t': "${DateTime.now().millisecondsSinceEpoch}"});
      return response;
    } catch (err) {
      print("请求超时");
      return null;
    }
  }

  static String getClipImg(String url, {int? x = 200, int? y = 200}) {
    return '$url?param=${x}y$y';
  }
}
