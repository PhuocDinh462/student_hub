import 'dart:math';

class MeetingRoom {
  static String generateMeetingRoomId() {
    // Sử dụng hàm random trong Dart để tạo ra 6 số ngẫu nhiên từ 0 đến 9
    var random = Random();
    String meetingRoomId = '';
    for (var i = 0; i < 6; i++) {
      meetingRoomId += random.nextInt(10).toString();
    }
    return meetingRoomId;
  }

  static String generateMeetingRoomCode() {
    // Sử dụng hàm random trong Dart để tạo ra 6 ký tự ngẫu nhiên
    var random = Random();
    const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
    String meetingRoomCode = '';
    for (var i = 0; i < 6; i++) {
      meetingRoomCode += characters[random.nextInt(characters.length)];
    }
    return meetingRoomCode;
  }
}
