import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final DateTime time;
  final String message;
  final String lang;
  Message({this.time, this.message,this.lang});

  static Message fromEntity(Map message) {
    Timestamp timestamp=message['time'];
    DateTime time=timestamp.toDate();
    return Message(
        time: time,
        lang: message['lang'],
        message: message['message']
    );
  }

  Map toEntity() {
    return {
      'time':time,
      'message':message,
      'lang':lang
    };
  }
}