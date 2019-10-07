import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_gandhinagar/dialogs/error_dialog.dart';
import 'package:devfest_gandhinagar/utils/devfest.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/home/team.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:devfest_gandhinagar/utils/tools.dart';
import 'package:devfest_gandhinagar/universal/profileAvatar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatelessWidget {
  static const String routeName = "/team";
  static List<Team> fullTeamList;
  static List<Team> coreTeamList;
  static List<Team> teamList;

  Widget socialActions(context, Team team) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.facebookF,
                size: 15,
              ),
              onPressed: () {
                launch(team.fbUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.twitter,
                size: 15,
              ),
              onPressed: () {
                launch(team.twitterUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.linkedinIn,
                size: 15,
              ),
              onPressed: () {
                launch(team.linkedinUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 15,
              ),
              onPressed: () {
                launch(team.githubUrl);
              },
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    fullTeamList = List<Team>();
    coreTeamList = List<Team>();
    teamList = List<Team>();

    return DevScaffold(
      title: "Team",
      body: FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection("team").document("data").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting) {
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
                  child: Text(Devfest.some_error_text),
                ),
              );
            } else {
              for (int i = 0; i < snapshot.data.data["data"].length; i++) {
                // add core team members to the coreTeamList and others to teamList and
                //join the two to get sorted list with core teams at the top
                if (Team.fromJson(Map<String, dynamic>.from(
                            snapshot.data.data["data"][i]))
                        .isCore ==
                    true) {
                  coreTeamList.add(Team.fromJson(Map<String, dynamic>.from(
                      snapshot.data.data["data"][i])));
                } else {
                  teamList.add(Team.fromJson(Map<String, dynamic>.from(
                      snapshot.data.data["data"][i])));
                }
              }

              coreTeamList.sort((a, b) {
                return a.index.compareTo(a.index);
              });

              teamList.sort((a, b) {
                return a.index.compareTo(a.index);
              });

              fullTeamList = coreTeamList + teamList;

              if (fullTeamList.length < 1) {
                return Center(
                  child: Text(Devfest.comingSoonText),
                );
              }
              return ListView.builder(
                itemCount: fullTeamList.length,
                shrinkWrap: true,
                itemBuilder: (c, i) {
                  return Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints.expand(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.height * 0.15,
                            ),
                            child: CustomPaint(
                              painter: ProfileAvatar(),
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.yellow,
                                ),
                                child: CircleAvatar(
                                  radius: 55,
                                  backgroundImage: CachedNetworkImageProvider(
                                    fullTeamList[i].image,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      fullTeamList[i].name,
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(seconds: 1),
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
                                      height: 5,
                                      color: Tools
                                          .multiColors[Random().nextInt(4)],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      fullTeamList[i].job,
                                      style:
                                          Theme.of(context).textTheme.subtitle,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                socialActions(context, fullTeamList[i]),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  fullTeamList[i].team,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
