import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterband/blocs/home/bloc.dart';
import './bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterband/models/message.dart';

class EarwigBloc extends Bloc<EarwigEvent, EarwigState> {
  StreamSubscription listener;

  @override
  EarwigState get initialState => InitialEarwigState();
  int startAtTimestamp = DateTime.now().millisecondsSinceEpoch;
  @override
  Stream<EarwigState> mapEventToState(
    EarwigEvent event,
  ) async* {
    if (event is StartListeningEvent) {
      yield* _mapListeningEventToState(event);
    } else if (event is PushMessageEvent) {
      print("***PushMessageEvent***");
      yield MessageReceivedEarwigState(event.message);
    } else if (event is StopListeningEvent) {
      print("***StopListeningEvent***");
      listener.cancel();
      yield EardeafState();
    }
  }

  Stream<EarwigState> _mapListeningEventToState(EarwigEvent event) async* {
    print("***CONNECTING TO DB***");
    Firestore _firestore = Firestore.instance;

    print(startAtTimestamp);
    listener = Firestore.instance
        .collection('message')
        .where('time', isGreaterThan: startAtTimestamp)
        .snapshots()
        .listen((data) {
      print("***OVER LISTENER " + startAtTimestamp.toString() + "***");
      data.documents
          .where((element) => element['time'] > startAtTimestamp)
          .forEach((element) {
        print("***OVER " + startAtTimestamp.toString() + "***");
        print(element.data);
        this.add(PushMessageEvent(Message.fromEntity(element.data)));
        print("***OVER***");
      });
      startAtTimestamp = DateTime.now().millisecondsSinceEpoch;
    });

    yield EarwiggingState();
    //print(message.data);
    //Message newMessage = Message.fromEntity(message.data);
    //yield MessageReceivedEarwigState(newMessage);

    //if switched off
    //listener.cancel();
  }
}
