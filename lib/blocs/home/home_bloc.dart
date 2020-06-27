import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  StreamSubscription cameraBlocSubscription;
  String message;
  Firestore _firestore;

  HomeBloc() {
    this.onChange.listen((e) {
      if ((e.eventData) == 'spokenword') {
        print('***SPOKEN WORD PROCESSING***');

        this.add(VoiceProcessedEvent());
      }
      if ((e.eventData) == 'notunderstand') {
        print('***SPOKEN WORD ERROR PROCESSING***');
        this.add(VoiceErrorEvent());
      }

    });
  }

  var changeController = new StreamController<CapturedEvent>();

  Stream<CapturedEvent> get onChange => changeController.stream;

  @override
  Future<void> close() {
    cameraBlocSubscription.cancel();
    return super.close();
  }

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event,) async* {
    if (event is StartBroadcastEvent) {
      yield* _mapStartBroadcastEventToState(event);
    }else if(event is VoiceProcessedEvent){
      _firestore=Firestore.instance;
     await _firestore.collection('message').add({'message':this.message});
      yield BroadcastSentState(message);
    }
  }


  Stream<HomeState> _mapStartBroadcastEventToState(
      HomeEvent event) async* {
    print("***START LISTENING***");
    SpeechToText speech = SpeechToText();
    bool available = await speech.initialize(
        onStatus: statusListener, onError: errorListener);
    if (available) {
      speech.listen(onResult: resultListener);
    }
    else {
      print("The user has denied the use of speech recognition.");
    }
    yield BroadcastSentState();
  }
  void resultListener(SpeechRecognitionResult result) {

    if(result.finalResult==true){
      print("${result.recognizedWords} - ${result.finalResult}");
      message=result.recognizedWords;
      changeController.add(new CapturedEvent('spokenword'));
    }


  }
  void errorListener(SpeechRecognitionError error) {
    print('errorListener: '+error.toString());
    changeController.add(new CapturedEvent('notunderstand'));
  }

  void statusListener(String status) {
    print('statusListener: '+status);
  }
}

class CapturedEvent {
  String eventData;
  CapturedEvent(this.eventData);
}
