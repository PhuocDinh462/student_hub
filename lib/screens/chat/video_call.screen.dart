import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/theme.dart';
import 'package:student_hub/screens/chat/widgets/control_panel.widget.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/display_text.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final deviceSize = context.deviceSize;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
              height: deviceSize.height * 0.35,
              width: deviceSize.width,
              decoration: BoxDecoration(
                  border: Border.all(color: text_700, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/avatar.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(5),
                  DisplayText(
                    text: 'Alex Xu',
                    style: textTheme.labelMedium!,
                  ),
                ],
              )),
          const Gap(15),
          Container(
              height: deviceSize.height * 0.35,
              width: deviceSize.width,
              decoration: BoxDecoration(
                  border: Border.all(color: text_700, width: 2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/avatar.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(5),
                  DisplayText(
                    text: 'Luis Pham',
                    style: textTheme.labelMedium!,
                  ),
                ],
              )),
          const Gap(15),
          ControlPanel(
            videoEnabled: true,
            audioEnabled: true,
            isConnectionFailed: false,
            onVideoToggle: () {},
            onAudioToggle: () {},
            onReconnected: () {},
            onMeetingEnd: () {},
          ),
        ]),
      ),
    );
  }
}
