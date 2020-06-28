import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterband/blocs/home/bloc.dart';
import 'package:flutterband/blocs/nav/bloc.dart';
import 'package:flutterband/blocs/earwig/bloc.dart';

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

_body(NavState state, BuildContext context) {
  if (state is InitialNavState || state is HomeNavState) {
    return  BlocConsumer<EarwigBloc, EarwigState>(
  listener: (context, state) {
  if(state is MessageReceivedEarwigState){
    Locale myLocale = Localizations.localeOf(context);
    print('YAY++++'+state.message.message+'++++YAY');
    BlocProvider.of<HomeBloc>(context)
        .add(StartIncomingEvent(state.message,myLocale.languageCode));
  }
  },
  builder: (context, state) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(20)),
        Image(image: AssetImage('assets/logo.png')),
        Padding(padding: EdgeInsets.all(20)),
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
                      .add(StartBroadcastEvent())
                },
                child: Text('Broadcast'))),
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
                  BlocProvider.of<EarwigBloc>(context)
                      .add(StartListeningEvent())
                },
                child: Text('Listen'))),
      ],
    );
  });

  }
}
