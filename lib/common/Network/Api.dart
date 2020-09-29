import 'package:dio/dio.dart';

import 'HttpManager.dart';
import 'UrlPath.dart';

/// 所有接口类
class Api {
  ///示例请求

  static login(Map<String, dynamic> param){
    FormData formData = new FormData.fromMap(param);
    return HttpManager.getInstance(baseUrl: UrlPath.baseUrl)
        .post(UrlPath.loginPath, params: formData);
  }

  static request(Map<String, dynamic> param) {
    return HttpManager.getInstance().get(UrlPath.testPath, params: param);
  }

  static requestOther(Map<String, dynamic> param) {
    return HttpManager.getInstance(baseUrl: UrlPath.otherUrl)
        .post(UrlPath.testPath, params: param);
  }
}
