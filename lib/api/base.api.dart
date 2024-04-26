import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

class BaseApi {
  Dio dio;

  BaseApi() : dio = Dio() {
    BaseOptions options = BaseOptions(
      baseUrl: dotenv.get('API_SERVER'),
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    );
    dio = Dio(options);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            String? token = await getToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
            }
            return handler.next(options);
          } catch (e) {
            return handler.next(options);
          }
        },
        onError: (DioException error, ErrorInterceptorHandler handler) {
          final UserProvider userProvider = Get.find();

          if (error.response?.statusCode == 401) {
            Get.defaultDialog(
              title: 'Session Expired',
              titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
              titleStyle: Get.theme.textTheme.displayLarge,
              content: const Column(
                children: [
                  Text('Please login again.'),
                  Gap(15),
                  Divider(
                    thickness: .5,
                    color: text_400,
                    height: 0,
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.only(bottom: 15),
              buttonColor: Colors.transparent,
              confirm: TextButton(
                onPressed: () => userProvider.removeCurrentUser(),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 25),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'OK',
                  style: Get.textTheme.titleMedium
                      ?.copyWith(color: Get.theme.colorScheme.primary),
                ),
              ),
              onWillPop: () async {
                userProvider.removeCurrentUser();
                return true;
              },
            );
          }
          return handler.next(error);
        },
      ),
    );
  }
}
