import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ResultData.dart';

/// 数据初步处理
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    try {
      if (option.contentType != null && option.contentType.contains("text")) {
        return new ResultData(response.data, true, 200);
      }

      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201) {
        ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段

        int code = response.data["code"];
        if (code == 1) { // 这里定义得有点不一样，定义code = 1 为成功，其它为失败
          return new ResultData(response.data["data"], true, 1,
              headers: response.headers,msg: response.data["msg"]);
        } else { // 不等于0 的code ， 直接Toast
          Fluttertoast.cancel();
          Fluttertoast.showToast(
              msg: response.data['msg'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red[400],
              textColor: Colors.white,
              fontSize: 16.0
          );
          return new ResultData(response.data, false, 200,
              headers: response.headers);
        }
      }
    } catch (e) {
      print("ResponseError====" + e.toString() + "****" + option.path);

      return new ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }

    return new ResultData(response.data, false, response.statusCode,
        headers: response.headers);
  }
}
