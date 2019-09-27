import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/home/session.dart';
import 'package:devfest_gandhinagar/home/speaker.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:devfest_gandhinagar/utils/tools.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SessionDetail extends StatelessWidget {
  static const String routeName = "/session_detail";
  final Session session;
  static Speaker speaker = Speaker();
  static List<Speaker> speakerList;

  SessionDetail({Key key, @required this.session}) : super(key: key);

  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
    speakerList = List<Speaker>();
    return DevScaffold(
      title: session.speakerName,
      body: FutureBuilder<DocumentSnapshot>(
        future:
            Firestore.instance.collection("speakers").document("data").get(),
        // .where("speaker_id", isEqualTo: session.speakerId)
        // .getDocuments(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              snapshot.connectionState != ConnectionState.active) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Center(
                child: SpinKitChasingDots(
                  color: Tools.multiColors[Random().nextInt(3)],
                ),
              ),
            );
          } else {
            // speaker = Speaker.fromJson(snapshot.data.documents.first.data);
            // print("No. of docs: ${snapshot.data.data["data"].length}");
            for (int i = 0; i < snapshot.data.data["data"].length; i++) {
              speakerList.add(Speaker.fromJson(
                  Map<String, dynamic>.from(snapshot.data.data["data"][i])));
              print(
                  "Speaker id: ${speakerList[i].speakerId} Name: ${speakerList[i].speakerName} Session id: ${session.speakerId}");
              if (speakerList[i].speakerId == session.speakerId) {
                speaker = speakerList[i];
              }
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: Hero(
                        tag: speaker.speakerImage,
                        child: CircleAvatar(
                          radius: 100.0,
                          backgroundImage: CachedNetworkImageProvider(
                            speaker.speakerImage,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${speaker.speakerDesc}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 14,
                            color: Tools.multiColors[Random().nextInt(4)],
                          ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "${speaker.speakerSession}",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.title.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      speaker.sessionDetail,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          .copyWith(fontSize: 13),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    socialActions(context),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
