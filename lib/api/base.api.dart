import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class BaseApi {
  Dio dio = Dio(options);

  static BaseOptions options = BaseOptions(
      baseUrl: dotenv.get('API_SERVER'),
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzksImZ1bGxuYW1lIjoidGJsb25nIiwiZW1haWwiOiJsMkBnbWFpbC5jb20iLCJyb2xlcyI6WyIxIl0sImlhdCI6MTcxMTgyNzU3OSwiZXhwIjoxNzEzMDM3MTc5fQ.ZT5VyNor49z7DPYoPxHEXOkbvsI4kyb39oLSZUOnHYE',
      });
}
