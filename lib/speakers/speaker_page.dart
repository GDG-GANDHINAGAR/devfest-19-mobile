import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_gandhinagar/dialogs/error_dialog.dart';
import 'package:devfest_gandhinagar/dialogs/loading_dialog.dart';
import 'package:devfest_gandhinagar/universal/profileAvatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/home/home_bloc.dart';
import 'package:devfest_gandhinagar/home/index.dart';
import 'package:devfest_gandhinagar/home/speaker.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:devfest_gandhinagar/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SpeakerPage extends StatelessWidget {
  static const String routeName = "/speakers";
  static List<Speaker> speakerList;

  Widget socialActions(context, Speaker speaker) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.facebookF,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.fbUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.twitter,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.twitterUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.linkedinIn,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.linkedinUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 15,
              ),
              onPressed: () {
                launch(speaker.githubUrl);
              },
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    // var state = _homeBloc.currentState as InHomeState;
    // var speakers = state.speakersData.speakers;
    speakerList = List<Speaker>();
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("speaker").getDocuments(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: LoadingDialog(),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: ErrorDialog(
                error: snapshot.error,
                child: Text("Oops! Error Occured!"),
              ),
            );
          } else {
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              speakerList
                  .add(Speaker.fromJson(snapshot.data.documents[i].data));
            }
            return DevScaffold(
              title: "Speakers",
              body: ListView.builder(
                itemCount: speakerList.length,
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
                                    speakerList[i].speakerImage,
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
                                      speakerList[i].speakerName,
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
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                socialActions(context, speakerList[i]),
                                Text(
                                  speakerList[i].speakerDesc,
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  speakerList[i].speakerSession,
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
              ),
            );
          }
        }
      },
    );
  }
}
