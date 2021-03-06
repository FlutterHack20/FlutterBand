import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutterband/models/message.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:translator/translator.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StreamSubscription earwigBlocSubscription;
  String voiceCapture;
  Firestore _firestore;
  int channel;

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
    earwigBlocSubscription.cancel();
    return super.close();
  }

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is ChannelBrowseEvent) {
      yield ChannelBrowseState(event.channel);
    }else
    if (event is StartBroadcastEvent) {
      this.channel = event.channel;
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/broadcast.mp3"),
        showNotification: true,
      );
      await new Future.delayed(const Duration(seconds: 1));
      yield* _mapStartBroadcastEventToState(event.channel);
    } else if (event is VoiceProcessedEvent) {
      _firestore = Firestore.instance;
      Message message =
          Message(message: this.voiceCapture, channel: this.channel);
      await _firestore.collection('message').add(message.toEntity());
      yield BroadcastSentState(message);
    } else if (event is StartIncomingEvent) {
      yield* _mapStartIncomingEventToState(event.message, event.languageCode);
    }
  }

  Stream<HomeState> _mapStartIncomingEventToState(
      Message message, String languageCode) async* {
    print("***START INCOMING***");
    final translator = new GoogleTranslator();

    String localizedMessageString =
        await translator.translate(message.message, to: languageCode) ??
            message.message;
    print("***TRANSLATED TEXT***");
    print(languageCode);
    print(localizedMessageString);
    FlutterTts flutterTts = FlutterTts();
    List voices = await flutterTts.getVoices;
    final _random = new Random();
    List localVoices = voices
        .where((element) => element.toString().startsWith(languageCode + '-'))
        .toList();
    if (localVoices.length > 0) {
      String localVoice = localVoices[_random.nextInt(localVoices.length)];
      flutterTts.setVoice(localVoice);
    }
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/static_burst.mp3"),
      showNotification: true,
    );
    flutterTts.speak(localizedMessageString);
    yield IncomingMessageState(localizedMessageString,channel);
  }

  Stream<HomeState> _mapStartBroadcastEventToState( int channel) async* {
    print("***START LISTENING***");
    SpeechToText speech = SpeechToText();
    bool available = await speech.initialize(
        onStatus: statusListener, onError: errorListener);
    if (available) {
      speech.listen(onResult: resultListener, cancelOnError: true);
    } else {
      print("The user has denied the use of speech recognition.");
    }
    yield BroadcastSentState(null,channel);
  }

  void resultListener(SpeechRecognitionResult result) {
    if (result.finalResult == true) {
      print("${result.recognizedWords} - ${result.finalResult}");
      voiceCapture = result.recognizedWords;
      changeController.add(new CapturedEvent('spokenword'));
    }
  }

  void errorListener(SpeechRecognitionError error) {
    print('errorListener: ' + error.toString());
    changeController.add(new CapturedEvent('notunderstand'));
  }

  void statusListener(String status) {
    print('statusListener: ' + status);
  }
}

class CapturedEvent {
  String eventData;
  CapturedEvent(this.eventData);
}
