import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterband/blocs/home/bloc.dart';
import 'package:flutterband/blocs/nav/bloc.dart';
import 'package:flutterband/blocs/earwig/bloc.dart';
import 'package:flutterband/widgets/cyber_knob/cyber_knob.dart';
import 'package:flutterband/widgets/message_display_widget.dart';
import 'package:flutterband/widgets/speak.dart';
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
             var size=MediaQuery.of(context).size;
          return Column(
            children: <Widget>[
              Image(image: AssetImage('assets/logo.png'),width:size.width*0.8 ,),

              Stack(
                children: <Widget>[

                  Container(

                    height:175,
                    child:
                    FlareActor('assets/flares/screen.flr',animation: 'Untitled',shouldClip: true,fit: BoxFit.scaleDown,),
                  ),
                  Container(padding: EdgeInsets.fromLTRB(50, 65, 50, 0),
                    width: size.width,height:100,
                    child:   MessageDisplayWidget(
                      message: latestMessage(),
                    ) ,
                  )
                ],
              ),

Row(
  children: <Widget>[

    Container(
      width: 100.0,
      height: 100.0,
      child: Speak(currentChannel),
    ),
    CyberKnob(),
    Container(
      width: 100.0,
      height: 100.0,
      child: Switcher(currentChannel),
    )
  ],
)



            ],
          );
        }));
  }
}
