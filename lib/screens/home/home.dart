import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:student_hub/routes/auth_route.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, AuthRoutes.login);
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      allowImplicitScrolling: true,
      pages: [
        PageViewModel(
          title: 'Empower Your Projects',
          body: 'Build your product with high-skilled student',
          image: _buildImage('Business-solution.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Discover Top Talent',
          body:
              'Find and onboard best-skilled student for your product. Student works to gain experience & skills from real-world projects',
          image: _buildImage('International-business-meeting.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: 'Unlock Opportunities',
          image: _buildImage('Business-merger.png'),
          bodyWidget: Column(
            children: [
              const Text(
                'StudentHub is university market place to connect high-skilled student and company on a real-world project',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 19),
              ),
              const Gap(50),
              TextButton(
                  onPressed: () => _onIntroEnd(context),
                  child: SizedBox(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Get Started',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            )),
                        const Gap(5),
                        Icon(
                          Icons.arrow_forward,
                          size: 22,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      ],
                    ),
                  ))
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      showDoneButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Get Started',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
