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
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzcsImZ1bGxuYW1lIjoidGJsb25nIiwiZW1haWwiOiJsQGdtYWlsLmNvbSIsInJvbGVzIjpbIjEiLCIxIl0sImlhdCI6MTcxMTg1ODU3OSwiZXhwIjoxNzEzMDY4MTc5fQ.fvQ2S4sblBKoTBDDJJvdGvGqzWSt4vl4C7hdg_uWGe4',
      });
}
