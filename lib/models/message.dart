import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final DateTime time;
  final String message;
  final String lang;
  final int channel;
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

  Map toEntity() {
    return {
      'time':time,
      'message':message,
      'lang':lang,
      'channel':channel
    };
  }
}
