import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/widgets/button.dart';
import 'package:pinput/pinput.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  late String pinInput;

  @override
  void initState() {
    super.initState();
    pinInput = '';
  }

  // Sign in
  void verifyCode(String pin) async {
    if (pin.length == 4) {
      print('Entered PIN is: $pin');
      // Call OTP verification function here
    } else {
      print('PIN must be 4 characters long');
      // Display error message if PIN is not 4 characters long
    }
  }

  void resendCode() async {
    setState(() {
      pinInput = '';
    });
  }

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

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Gap(50),
              // Verify Code
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Verify Code',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              // Enter OTP
              const Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Enter OTP',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              const Gap(30),

              // OTP input
              Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    border: Border.all(color: primary_300),
                  ),
                ),
                onCompleted: (pin) {
                  verifyCode(pin);
                },
                onChanged: (pin) {
                  setState(() {
                    pinInput = pin;
                  });
                },
              ),
              const Gap(30),

              // Code was sent to your email
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Code was sent to your email',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'This code expires in',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      Text(
                        '5 minutes',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold, color: primary_300),
                      ),
                    ],
                  ),
                ],
              ),

              const Gap(30),
              // Verify Code
              Button(
                onTap: () {
                  verifyCode(pinInput);
                },
                colorButton: primary_300,
                colorText: text_50,
                text: 'Verify Code',
              ),
              const Gap(25),
              // Resend Code
              Button(
                onTap: resendCode,
                colorButton: primary_300,
                colorText: text_50,
                text: 'Resend Code',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
