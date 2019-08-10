import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/agenda/session_list.dart';
import 'package:devfest_gandhinagar/home/index.dart';
import 'package:devfest_gandhinagar/home/session.dart';

class WebScreen extends StatelessWidget {
  final HomeBloc homeBloc;

  const WebScreen({Key key, this.homeBloc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var webSessions = sessions.where((s) => s.track == "web").toList();
    return SessionList(
      allSessions: webSessions,
    );
  }
}
