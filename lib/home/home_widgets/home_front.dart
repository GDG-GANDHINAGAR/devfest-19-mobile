import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/agenda/agenda_page.dart';
import 'package:devfest_gandhinagar/config/index.dart';
import 'package:devfest_gandhinagar/map/map_page.dart';
import 'package:devfest_gandhinagar/feedback/feedback_page.dart';
import 'package:devfest_gandhinagar/speakers/speaker_page.dart';
import 'package:devfest_gandhinagar/sponsors/sponsor_page.dart';
import 'package:devfest_gandhinagar/team/team_page.dart';
import 'package:devfest_gandhinagar/universal/image_card.dart';
import 'package:devfest_gandhinagar/utils/devfest.dart';
import 'package:devfest_gandhinagar/utils/tools.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFront extends StatefulWidget {
  @override
  _HomeFrontState createState() => _HomeFrontState();
}

class _HomeFrontState extends State<HomeFront> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // print("Widget Built");
      if (Devfest.prefs.getBool(Devfest.isUpdatedPref ?? true)) {
        print(
            "Is App Updated: ${Devfest.prefs.getBool(Devfest.isUpdatedPref ?? true)}");
      } else {
        print("App is not Updated");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Text("Update available"),
              content: Text(
                  "We highly recommend using the version ${Devfest.prefs.getString(Devfest.recommendedVersionPref)} for the best experience.\nDownload now?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: () {
                    launch(
                        "https://github.com/GDG-GANDHINAGAR/devfest-19-mobile/releases");
                  },
                ),
                FlatButton(
                  child: Text("Remind me later"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  List<Widget> devFestTexts(context) => [
        Text(
          Devfest.welcomeText,
          style: Theme.of(context).textTheme.headline,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          Devfest.descText,
          style: Theme.of(context).textTheme.caption,
          textAlign: TextAlign.center,
        ),
      ];

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget newActionsFeedbackEnabled(context) => Wrap(
        alignment: WrapAlignment.center,
        spacing: 20.0,
        runSpacing: 20.0,
        children: <Widget>[
          ActionCard(
            icon: Icons.schedule,
            color: Colors.red,
            title: Devfest.agenda_text,
            onPressed: () => Navigator.pushNamed(context, AgendaPage.routeName),
          ),
          ActionCard(
            icon: Icons.person,
            color: Colors.green,
            title: Devfest.speakers_text,
            onPressed: () =>
                Navigator.pushNamed(context, SpeakerPage.routeName),
          ),
          ActionCard(
            icon: Icons.people,
            color: Colors.amber,
            title: Devfest.team_text,
            onPressed: () => Navigator.pushNamed(context, TeamPage.routeName),
          ),
          ActionCard(
            icon: Icons.attach_money,
            color: Colors.purple,
            title: Devfest.sponsor_text,
            onPressed: () =>
                Navigator.pushNamed(context, SponsorPage.routeName),
          ),
          ActionCard(
            icon: Icons.map,
            color: Colors.blue,
            title: Devfest.map_text,
            onPressed: () => Navigator.pushNamed(context, MapPage.routeName),
          ),
          ActionCard(
            icon: Icons.feedback,
            color: Colors.blue,
            title: Devfest.feedback_text,
            onPressed: () =>
                Navigator.pushNamed(context, FeedbackPage.routeName),
          ),
        ],
      );

  Widget newActionsFeedbackDisabled(context) => Wrap(
        alignment: WrapAlignment.center,
        spacing: 20.0,
        runSpacing: 20.0,
        children: <Widget>[
          ActionCard(
            icon: Icons.schedule,
            color: Colors.red,
            title: Devfest.agenda_text,
            onPressed: () => Navigator.pushNamed(context, AgendaPage.routeName),
          ),
          ActionCard(
            icon: Icons.person,
            color: Colors.green,
            title: Devfest.speakers_text,
            onPressed: () =>
                Navigator.pushNamed(context, SpeakerPage.routeName),
          ),
          ActionCard(
            icon: Icons.people,
            color: Colors.amber,
            title: Devfest.team_text,
            onPressed: () => Navigator.pushNamed(context, TeamPage.routeName),
          ),
          ActionCard(
            icon: Icons.attach_money,
            color: Colors.purple,
            title: Devfest.sponsor_text,
            onPressed: () =>
                Navigator.pushNamed(context, SponsorPage.routeName),
          ),
          ActionCard(
            icon: Icons.map,
            color: Colors.blue,
            title: Devfest.map_text,
            onPressed: () => Navigator.pushNamed(context, MapPage.routeName),
          ),
        ],
      );

  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.facebookF),
              onPressed: () async {
                await _launchURL("https://facebook.com/GDGGandhinagar");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.twitter),
              onPressed: () async {
                await _launchURL("https://twitter.com/GDG_Gandhinagar");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.meetup),
              onPressed: () async {
                await _launchURL("https://www.meetup.com/GDG-Gandhinagar/");
              },
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.slack),
              onPressed: () async {
                await _launchURL("http://gdg-gandhinagar.slack.com");
              },
            ),
          ],
        ),
      );

  Widget homePage(
      {@required BuildContext context, @required bool feedbackVisible}) {
    // showUpdateDialog(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ImageCard(
              img: ConfigBloc().darkModeOn
                  ? Devfest.banner_dark
                  : Devfest.banner_light,
            ),
            SizedBox(
              height: 20,
            ),
            ...devFestTexts(context),
            SizedBox(
              height: 20,
            ),
            //control visibility of feedback form
            feedbackVisible
                ? newActionsFeedbackEnabled(context)
                : newActionsFeedbackDisabled(context),
            SizedBox(
              height: 20,
            ),
            socialActions(context),
            SizedBox(
              height: 20,
            ),
            Text(
              Devfest.app_version,
              style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection("homepage")
          .document("data")
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.none ||
            snapshot.connectionState == ConnectionState.waiting) {
          return homePage(context: context, feedbackVisible: false);
        } else {
          if (snapshot.hasError) {
            print("Error Occured:${snapshot.error}");
            return homePage(context: context, feedbackVisible: false);
          } else {
            if (snapshot.data.data["meta"]["app_version_code"] ==
                Devfest.app_version_code) {
              return homePage(
                context: context,
                feedbackVisible: snapshot.data.data["meta"]["feedback_active"],
              );
            } else {
              return homePage(
                context: context,
                feedbackVisible: snapshot.data.data["meta"]["feedback_active"],
              );
            }
          }
        }
      },
    );
    // return showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text("Update Available"),
    //       content: Text(
    //           "A new version v${snapshot.data.data["meta"]["app_version_code"]} of the app is available. Download now?"),
    //       actions: <Widget>[
    //         FlatButton(
    //           child: Text("OK"),
    //           onPressed: () {
    //             launch("https://devfest.gdggandhinagar.org");
    //           },
    //         ),
    //         FlatButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           child: Text("Cancel"),
    //         )
    //       ],
    //     );
    //   },
    // );
    // return SingleChildScrollView(
    //   child: Padding(
    //     padding: const EdgeInsets.all(12.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: <Widget>[
    //         ImageCard(
    //           img: ConfigBloc().darkModeOn
    //               ? Devfest.banner_dark
    //               : Devfest.banner_light,
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         ...devFestTexts(context),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         //streambuilder controlled feedback button
    //         StreamBuilder<DocumentSnapshot>(
    //           stream: Firestore.instance
    //               .collection("homepage")
    //               .document("data")
    //               .snapshots(),
    //           builder: (BuildContext context,
    //               AsyncSnapshot<DocumentSnapshot> snapshot) {
    //             if (snapshot.connectionState == ConnectionState.none ||
    //                 snapshot.connectionState == ConnectionState.waiting) {
    //               return newActionsFeedbackDisabled(context);
    //             } else {
    //               if (snapshot.hasError) {
    //                 print("Has error ${snapshot.error}");
    //                 return newActionsFeedbackDisabled(context);
    //               } else {
    //                 if (snapshot.data.data["meta"]["feedback_active"] == true) {
    //                   return newActionsFeedbackEnabled(context);
    //                 } else {
    //                   return newActionsFeedbackDisabled(context);
    //                 }
    //               }
    //             }
    //           },
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         socialActions(context),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Text(
    //           Devfest.app_version,
    //           style: Theme.of(context).textTheme.caption.copyWith(fontSize: 10),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class ActionCard extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String title;
  final Color color;

  const ActionCard({Key key, this.onPressed, this.icon, this.title, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onPressed,
      child: Ink(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: ConfigBloc().darkModeOn
              ? Tools.hexToColor("#1f2124")
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: !ConfigBloc().darkModeOn
              ? [
                  BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
