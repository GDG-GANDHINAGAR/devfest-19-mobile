import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_gandhinagar/dialogs/error_dialog.dart';
import 'package:devfest_gandhinagar/home/session.dart';
import 'package:devfest_gandhinagar/home/speaker.dart';
import 'package:devfest_gandhinagar/utils/devfest.dart';
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
              child: Text("Web"),
              icon: Icon(
                FontAwesomeIcons.chrome,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Mobile & ML"),
              icon: Icon(
                FontAwesomeIcons.mobile,
                size: 12,
              ),
            ),
            Tab(
              child: Text("Cloud & Misc."),
              icon: Icon(
                FontAwesomeIcons.cloud,
                size: 12,
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future:
              Firestore.instance.collection("speakers").document("data").get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                    child: Text(Devfest.some_error_text),
                    error: snapshot.error,
                  ),
                );
              } else {
                sessionList = List<Session>();
                // for (int i = 0; i < snapshot.data.documents.length; i++) {
                //   sessionList
                //       .add(Session.fromJson(snapshot.data.documents[i].data));
                // }
                for (int i = 0; i < snapshot.data.data["data"].length; i++) {
                  if (Speaker.fromJson(Map<String, dynamic>.from(
                              snapshot.data.data["data"][i]))
                          .isVisible ==
                      true)
                    sessionList.add(Session.fromJson(Map<String, dynamic>.from(
                        snapshot.data.data["data"][i])));
                }
                return TabBarView(
                  children: <Widget>[
                    WebScreen(
                      key: UniqueKey(),
                      homeBloc: _homeBloc,
                      sessions: sessionList,
                    ),
                    MobileScreen(
                      key: UniqueKey(),
                      homeBloc: _homeBloc,
                      sessions: sessionList,
                    ),
                    CloudScreen(
                      key: UniqueKey(),
                      homeBloc: _homeBloc,
                      sessions: sessionList,
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}
