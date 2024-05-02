import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VideoConference extends StatelessWidget {
  const VideoConference({super.key});

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: int.parse(dotenv.get('ZEGO_APP_ID')),
      appSign: dotenv.get('ZEGO_APP_SIGN'),
      userID: '1',
      userName: 'test',
      callID: '2',
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
