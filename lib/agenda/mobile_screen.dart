import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/agenda/session_list.dart';
import 'package:devfest_gandhinagar/home/index.dart';
import 'package:devfest_gandhinagar/home/session.dart';

class MobileScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  final List<Session> sessions;

  const MobileScreen({Key key, this.homeBloc, @required this.sessions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mobileSessions =
        sessions.where((s) => s.track == "mobile" || s.track == "ml").toList();
    return SessionList(
      allSessions: mobileSessions,
    );
  }
}
