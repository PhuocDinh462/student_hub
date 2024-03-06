import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:pinput/pinput.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({super.key});

  //sign in
  void verifyCode(pin) async {
    if (pin.length == 4) {
      print('Entered PIN is: pin');
      // Gọi hàm xác thực OTP ở đây
    } else {
      print('PIN must be 4 characters long');
      // Hiển thị thông báo lỗi nếu PIN không đủ 4 ký tự
    }
  }

  void resendCode() async {}
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    String pinInput = '';
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(50),
              //Verify Code
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Verify Code',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              //Enter OTP
              const Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Enter OTP',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const Gap(30),
              //OTP input
              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: Colors.blue),
                  ),
                ),
                onCompleted: (pin) {
                  verifyCode(pin);
                },
                onChanged: (pin) {
                  pinInput = pin;
                },
              ),
              const Gap(30),

              //Code was sent to your email
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Code was sent to your email',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'This code expires in',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      Gap(10),
                      Text(
                        '5 minutes',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),

              const Gap(30),
              //Verify Code
              Button(
                onTap: () {
                  verifyCode(pinInput);
                },
                colorButton: Colors.blue,
                colorText: Colors.white,
                text: 'Verify Code',
              ),
              const Gap(25),
              //Resend Code
              Button(
                onTap: resendCode,
                colorButton: const Color(0xFFFDEDD9),
                colorText: Colors.black,
                text: 'Resend Code',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
