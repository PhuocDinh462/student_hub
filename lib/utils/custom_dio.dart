import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/providers/providers.dart';

Dio publicDio = Dio(
  BaseOptions(
    baseUrl: dotenv.env['API_SERVER']!,
  ),
);

Dio privateDio = Dio(
  BaseOptions(
    baseUrl: dotenv.env['API_SERVER']!,
    headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjUsImZ1bGxuYW1lIjoicGh1b2MiLCJlbWFpbCI6InBodW9jZGluaDQ2MkBnbWFpbC5jb20iLCJyb2xlcyI6WzFdLCJpYXQiOjE3MTI0NzYwMTYsImV4cCI6MTcxMzY4NTYxNn0.x2Umz26p5rqVVqVSZF2L5tntGheEuPIEjGrUYhairpg',
    },
  ),
)..interceptors.add(
    InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) {
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
              onPressed: () {
                ThemeProvider themeProvider = Get.find();
                print('theme: ${themeProvider.getTheme.toString()}');
                print('login');
                Get.back();
              },
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
              print('login');
              return true;
            },
          );
        }
        return handler.next(error);
      },
    ),
  );
