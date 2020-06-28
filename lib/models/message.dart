import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final DateTime time;
  final String message;
  final String lang;
  final int channel;
  static const DEFAULT_CHANNEL=10;
  Message({this.time, this.message,this.lang,this.channel});

  static Message fromEntity(Map message) {

    DateTime time= message['time']!=null?DateTime.now():DateTime.parse(message['time']);
    return Message(
        time: time,
        lang: message['lang'],
        message: message['message'],
        channel: message['channel']
    );
  }

  Map<String, Object>  toEntity() {
    return {
      'time':time??new DateTime.now(),
      'message':message,
      'lang':lang,
      'channel':channel??DEFAULT_CHANNEL
    };
  }
}
