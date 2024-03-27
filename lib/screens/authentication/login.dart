import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/routes/auth_route.dart';
import 'package:student_hub/routes/company_route.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:student_hub/widgets/text_field.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

//tien01@gmail.com Tien123@@

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String? apiServer = dotenv.env['API_SERVER'];

  //sign in
  void signIn() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    FocusScope.of(context).unfocus();

    if (email.isEmpty || password.isEmpty) {
      showSnackBar('Please fill in all fields', false);
      return;
    }

    try {
      final dio = Dio();
      final response = await dio.post(
        '$apiServer/auth/sign-in',
        data: {
          'email': email,
          'password': password,
        },
      );

      final String token = response.data['result']['token'];
      saveToken(token);

      if (response.statusCode == 201) {
        // navigateToProfile();
        showSnackBar('Login Successfully', true);
      } else if (response.statusCode == 422) {
        showSnackBar('Invalid Credentials', false);
      } else {
        showSnackBar('Invalid Credentials', false);
      }
    } catch (e) {
      showSnackBar('Invalid Credentials', false);
    }
  }

  void navigateToProfile() async {
    await Navigator.pushNamed(context, CompanyRoutes.account);
  }

  void saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    // sau này lấy token bằng cách
    // Future<String?> getToken() async {
    //       SharedPreferences prefs = await SharedPreferences.getInstance();
    //       return prefs.getString('token');
    //     }
  }

  void showSnackBar(String message, bool success) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: success ? 'Congrats!!' : 'On Hey!!',
        message: message,
        contentType: success ? ContentType.success : ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    // final materialBanner = MaterialBanner(
    //   /// need to set following properties for best effect of awesome_snackbar_content
    //   elevation: 0,
    //   backgroundColor: Colors.transparent,
    //   forceActionsBelow: true,
    //   content: AwesomeSnackbarContent(
    //     title: success ? 'Congrats!!' : 'On Hey!!',
    //     message:
    //         'This is an example error message that will be shown in the body of materialBanner!',

    //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
    //     contentType: success ? ContentType.success : ContentType.failure,
    //     // to configure for material banner
    //     inMaterialBanner: true,
    //   ),
    //   actions: const [SizedBox.shrink()],
    // );
    // ScaffoldMessenger.of(context).showMaterialBanner(materialBanner);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const Gap(50),
                  //welcome back
                  Text(
                    'Welcome back to StudentHub!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Gap(30),
                  //user name textfield
                  InputText(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    icon: Icons.email,
                  ),
                  const Gap(20),
                  // password textfield
                  InputText(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    icon: Icons.lock,
                  ),
                  const Gap(10),
                  //forgot password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AuthRoutes.forgotPassword);
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: primary_300,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(25),
                  //sign in button
                  Button(
                    onTap: signIn,
                    colorButton: primary_300,
                    colorText: text_50,
                    text: 'Sign In',
                  ),

                  const Gap(25),
                  // not a member ? register now
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an Account?',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AuthRoutes.signUpOption);
                        },
                        child: const Text(
                          'Sign up here',
                          style: TextStyle(
                            color: primary_200,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
