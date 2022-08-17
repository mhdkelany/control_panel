import 'package:dio/dio.dart' ;
class DioHelper
{
  static Dio ?dio;
  static  init()
  {
    dio=Dio(
        BaseOptions(
          baseUrl: 'https://ibrahim-store.com/api/',
          receiveDataWhenStatusError: true,
          // connectTimeout: 5000
        )
    );
  }
  static Future<Response> getData ({
    required String url,
    dynamic query,
    String ?lang='en',
    String ?token
  })async
  {

    dio!.options.headers=
    {
      // 'lang':lang,
      'Content-Type': 'application/json',
      'Authorization':token??''

    };
    print('token is $token');
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
  static Future<Response> postData({
    required String url,
    dynamic query,
    required dynamic data,
    String? lang='en',
    String? token,
  })async
  {
    dio!.options.headers=
    {
      // 'lang':lang,
      'Content-Type': 'application/json',
      'Authorization':token,
      'Charset': 'utf-8'

    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    dynamic query,
    required dynamic data,
    String? lang='en',
    String? token,
  })async
  {
    dio!.options.headers=
    {
      'Content-Type':'application/json',
      'Authorization':token??''
    };

    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}