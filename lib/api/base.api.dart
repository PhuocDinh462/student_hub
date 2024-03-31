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
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjAsImZ1bGxuYW1lIjoic3RyaW5nIiwiZW1haWwiOiJsbGxAbWFpbC5jb20iLCJyb2xlcyI6WyIxIl0sImlhdCI6MTcxMTg5MDAxMiwiZXhwIjoxNzEzMDk5NjEyfQ.eqAqSTo-GoMRX5uaee82er_8X7QLh9MnaxeiWKAbRCo',
      });
}
