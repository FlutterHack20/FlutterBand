import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



abstract class NavState extends Equatable {
  NavState();
}

class InitialNavState extends NavState {
  @override
  List<Object> get props => [];
  final String _name = null;
  final IconData _iconData = null;
}

class HomeNavState extends NavState {
  @override
  List<Object> get props => [];
  final String _name = 'Home';
  final IconData _iconData = null;
}

