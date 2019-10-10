import 'package:devfest_gandhinagar/home/speaker.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/agenda/session_list.dart';
import 'package:devfest_gandhinagar/home/index.dart';

class MLScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  final List<Speaker> sessions;

  const MLScreen({Key key, this.homeBloc, @required this.sessions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mlSessions =
        sessions.where((s) => s.track == "cloud" || s.track == "misc").toList();
    return SessionList(
      allSessions: mlSessions,
    );
  }
}
