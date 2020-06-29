import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterband/blocs/home/bloc.dart';
import 'package:flutterband/blocs/nav/bloc.dart';
import 'package:flutterband/blocs/earwig/bloc.dart';
import 'package:flutterband/widgets/cyber_knob/cyber_knob.dart';
import 'package:flutterband/widgets/message_display_widget.dart';
import 'package:flutterband/widgets/switch.dart';

import 'blocs/earwig/earwig_event.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  int navIndex = 0;
  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(builder: (_, state) {
      return Scaffold(
          appBar: AppBar(title: Text('Flutterband v.1.0.beta')),
          extendBodyBehindAppBar: false,
          body: _body(state, context));
    });
  }
}

String _latestMessage = 'awaiting messages';
int _channel = 10;

_body(NavState state, BuildContext context) {
  latestMessage() => _latestMessage;
  currentChannel() => _channel;

  if (state is InitialNavState || state is HomeNavState) {
    return MultiBlocListener(
        listeners: [
          BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is IncomingMessageState) {
                _latestMessage = state.message;
              }
            },
          ),
        ],
        child:
            BlocConsumer<EarwigBloc, EarwigState>(listener: (context, state) {
          if (state is MessageReceivedEarwigState) {
            Locale myLocale = Localizations.localeOf(context);
            print('YAY++++' + state.message.message + '++++YAY');
            BlocProvider.of<HomeBloc>(context)
                .add(StartIncomingEvent(state.message, myLocale.languageCode));
          }
        }, builder: (context, state) {
          return Column(
            children: <Widget>[
              Image(image: AssetImage('assets/logo.png')),
              Container(
                width: 300,
                height: 100,
                child: MessageDisplayWidget(
                  message: latestMessage(),
                ),
              ),
              CyberKnob(),
              ButtonTheme(
                  minWidth: 200.0,
                  height: 50.0,
                  buttonColor: Color.fromRGBO(67, 132, 165, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                          width: 1.00, color: Color.fromRGBO(45, 92, 110, 1))),
                  textTheme: ButtonTextTheme.primary,
                  child: RaisedButton(
                      onPressed: () => {
                            BlocProvider.of<HomeBloc>(context)
                                .add(StartBroadcastEvent(currentChannel()))
                          },
                      child: Text('Broadcast'))),
              Container(
                width: 100.0,
                height: 100.0,
                child: Switcher(currentChannel),
              )
            ],
          );
        }));
  }
}
