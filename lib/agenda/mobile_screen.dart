import 'package:devfest_gandhinagar/home/speaker.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/agenda/session_list.dart';
import 'package:devfest_gandhinagar/home/index.dart';

class MobileScreen extends StatelessWidget {
  final HomeBloc homeBloc;
  final List<Speaker> sessions;

  const MobileScreen({Key key, this.homeBloc, @required this.sessions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var mobileSessions = sessions.where((s) => s.track == "mobile").toList();
    return SessionList(
      allSessions: mobileSessions,
    );
  }
}
