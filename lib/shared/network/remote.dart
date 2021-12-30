import 'package:dio/dio.dart';

class DioHelper {

  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
       ));
  }

  static Future<Response> postData({
    required String url,
    String lang= 'en',
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token
  }) async
  {
    dio.options.headers=
    {
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token ?? ''
    };
    return dio.post(
        url,
        data: data,
        queryParameters: query
    );
  }

  static Future<Response> getData({
    required String url,
    String lang= 'en',
    Map<String, dynamic>? query,
    String? token
  }) async
  {
    dio.options.headers=
    {
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token ?? ''
    };
    return dio.get(
        url,
        queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    String lang= 'en',
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? token
  }) async
  {
    dio.options.headers=
    {
      'lang' : lang,
      'Content-Type' : 'application/json',
      'Authorization' : token ?? ''
    };
    return dio.put(
        url,
        data: data,
        queryParameters: query
    );
  }
}
