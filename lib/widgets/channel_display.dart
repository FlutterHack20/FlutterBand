import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterband/blocs/earwig/earwig_bloc.dart';
import 'package:flutterband/blocs/earwig/earwig_state.dart';

class ChannelDisplay extends StatelessWidget {
  final String channel;

  ChannelDisplay({
    Key key,
    this.channel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EarwigBloc earwigBloc = BlocProvider.of<EarwigBloc>(context);
    String _channel = '0.0';

    return BlocBuilder<EarwigBloc, EarwigState>(
        bloc: earwigBloc,
        builder: (context, state) {
          if (state is MessageReceivedEarwigState) {
            _channel = state.message.channel.toDouble().toString();
            print('CHANNEL: $_channel');
          }
          return Container(
            child: Text(_channel,  style: TextStyle(color: Colors.lightBlueAccent,fontSize: 200,fontWeight: FontWeight.bold,fontFamily: "Digital"))
            ,
          );
        });
  }
}
