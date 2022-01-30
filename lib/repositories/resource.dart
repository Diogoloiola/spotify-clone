import 'package:dio/dio.dart';

class Resource {
  late final Dio dio;

  Resource(String baseUrl, Map<String, String> headers) {
    dio = Dio(BaseOptions(baseUrl: baseUrl, headers: headers));
  }
}
