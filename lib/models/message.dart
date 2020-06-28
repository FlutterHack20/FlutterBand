import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final DateTime time;
  final String message;
  final String lang;
  final int channel;
  static const DEFAULT_CHANNEL=10;
  Message({this.time, this.message,this.lang,this.channel});

  static Message fromEntity(Map message) {
    Timestamp timestamp=message['time'];
    DateTime time=timestamp.toDate();
    return Message(
        time: time,
        lang: message['lang'],
        message: message['message'],
        channel: message['channel']
    );
  }

  Map<String, Object>  toEntity() {
    return {
      'time':time??new DateTime.now().toIso8601String(),
      'message':message,
      'lang':lang,
      'channel':channel??DEFAULT_CHANNEL
    };
  }
}
