import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_gandhinagar/dialogs/error_dialog.dart';
import 'package:devfest_gandhinagar/home/session.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/agenda/cloud_screen.dart';
import 'package:devfest_gandhinagar/agenda/mobile_screen.dart';
import 'package:devfest_gandhinagar/agenda/web_screen.dart';
import 'package:devfest_gandhinagar/home/index.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:devfest_gandhinagar/utils/tools.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgendaPage extends StatelessWidget {
  static const String routeName = "/agenda";
  static List<Session> sessionList;

  @override
  Widget build(BuildContext context) {
    var _homeBloc = HomeBloc();
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("session").getDocuments(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: SpinKitChasingDots(
                color: Tools.multiColors[Random().nextInt(3)],
              ),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: ErrorDialog(
                error: snapshot.error,
              ),
            );
          } else {
            sessionList = List<Session>();
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              sessionList
                  .add(Session.fromJson(snapshot.data.documents[i].data));
            }
            // print("Session data: $sessionList");
            return DefaultTabController(
              length: 3,
              child: DevScaffold(
                title: "Agenda",
                tabBar: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Tools.multiColors[Random().nextInt(4)],
                  labelStyle: TextStyle(
                    fontSize: 12,
                  ),
                  isScrollable: false,
                  tabs: <Widget>[
                    Tab(
                      child: Text("Cloud"),
                      icon: Icon(
                        FontAwesomeIcons.cloud,
                        size: 12,
                      ),
                    ),
                    Tab(
                      child: Text("Mobile"),
                      icon: Icon(
                        FontAwesomeIcons.mobile,
                        size: 12,
                      ),
                    ),
                    Tab(
                      child: Text("Web & More"),
                      icon: Icon(
                        FontAwesomeIcons.chrome,
                        size: 12,
                      ),
                    )
                  ],
                ),
                body: TabBarView(
                  children: <Widget>[
                    CloudScreen(
                      key: UniqueKey(),
                      homeBloc: _homeBloc,
                      sessions: sessionList,
                    ),
                    MobileScreen(
                      key: UniqueKey(),
                      homeBloc: _homeBloc,
                      sessions: sessionList,
                    ),
                    WebScreen(
                      key: UniqueKey(),
                      homeBloc: _homeBloc,
                      sessions: sessionList,
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
