import 'dart:convert';

import 'package:dio/dio.dart';

class HttpUtils {
  static final BASE_URL = "http://gank.io/";
  static final BASE_PAPER_URL = "http://service.picasso.adesk.com/v1/vertical/vertical";
  static final BASE_EYE_URL = "http://baobab.kaiyanapp.com/api/v4/tabs/selected";

  static Dio gankDio=new Dio(Options(
      baseUrl: BASE_URL, connectTimeout: 5000, receiveTimeout: 5000));

  static Dio PaperDio=new Dio(Options(
    baseUrl: BASE_PAPER_URL,connectTimeout: 5000,receiveTimeout: 5000
  ));
  static Dio EyeDio = new Dio(Options(
      baseUrl: BASE_EYE_URL, connectTimeout: 5000, receiveTimeout: 5000
  ));

  static Map<String,Dio> dioMaps={"gank":gankDio,"paper":PaperDio,"eye":EyeDio};

  // factory HttpUtils() => _getInstance();


//  static HttpUtils _instance;
//
//  static HttpUtils _getInstance() {
//    if (_instance == null) {
//      _instance = HttpUtils();
//    }
//    return _instance;
//  }

  static Future<String> get(String path, Map<String, String> params,{String type}) async {
    Dio dio=dioMaps[type??"gank"];
    Response response = await dio.get(path, data: params);
    var data = response.data;
    if(data is String){
      return data;
    }else if(data is Map){
      return json.encode(data);
    }else if (data is List){
      return json.encode(data);
    }
    return data.toString();

  }

  static Future<dynamic> getDynamic(String path, Map<String, String> params,{String type}) async{
    Dio dio=dioMaps[type??"gank"];
    Response response = await dio.get(path, data: params);
    var data = response.data;
    return data;
  }

}
