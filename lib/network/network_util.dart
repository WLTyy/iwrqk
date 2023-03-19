import 'package:dio/dio.dart';

class NetworkUtil {
  static final NetworkUtil _singleton = NetworkUtil._internal();

  factory NetworkUtil() {
    return _singleton;
  }

  late Dio _dio;

  NetworkUtil._internal() {
    _dio = Dio();
    _dio.options.connectTimeout = Duration(seconds: 15);
    _dio.options.receiveTimeout = Duration(seconds: 15);
    _dio.options.headers = {
      "accept": "application/json",
      "accept-encoding": "gzip, deflate, br",
      "accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
      "content-type": "application/json",
      "user-agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/111.0.0.0 Safari/537.36 Edg/111.0.1661.44"
    };
    _dio.interceptors.add(LogInterceptor());
  }

  Future<Response> get(String path,
      {String? host,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    host ??= "api.iwara.tv";

    final response = await _dio.get("https://$host$path",
        queryParameters: queryParameters, options: Options(headers: headers));
    return response;
  }

  Future<Response> getFullUrl(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    final response = await _dio.get(url,
        queryParameters: queryParameters, options: Options(headers: headers));
    return response;
  }

  Future<Response?> post(String path, {dynamic data}) async {
    final response = await _dio.post(
      path,
      data: data,
    );
    return response;
  }

  void dispose() {
    _dio.close();
  }
}
