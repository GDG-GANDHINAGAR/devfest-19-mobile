import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/agenda/session_list.dart';
import 'package:devfest_gandhinagar/home/index.dart';
import 'package:devfest_gandhinagar/home/session.dart';

class CloudScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  final List<Session> sessions;

  const CloudScreen({Key key, this.homeBloc,@required this.sessions}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cloudSessions = sessions.where((s) => s.track == "cloud").toList();
    return SessionList(
      allSessions: cloudSessions,
    );
  }
}
