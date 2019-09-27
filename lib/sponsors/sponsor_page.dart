import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest_gandhinagar/dialogs/error_dialog.dart';
import 'package:devfest_gandhinagar/home/sponsor.dart';
import 'package:devfest_gandhinagar/utils/devfest.dart';
import 'package:devfest_gandhinagar/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorPage extends StatelessWidget {
  static const String routeName = "/sponsor";
  static List<Sponsor> sponsorsList = new List<Sponsor>();

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      title: "Sponsors",
      body: Container(
        color: Colors.black,
        child: FutureBuilder<DocumentSnapshot>(
          future:
              Firestore.instance.collection("homepage").document("data").get(),
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
                    error: snapshot.error,
                    child: Text(Devfest.some_error_text),
                  ),
                );
              } else {
                Map<String, List<dynamic>> map =
                    Map<String, List<dynamic>>.from(
                        snapshot.data.data["sponsors"]);

                int count = 0;
                for (int i = 0; i < map.length; i++) {
                  String sponsorCategory = map.keys.toList()[i];
                  for (int j = 0; j < map[sponsorCategory].length; j++) {
                    sponsorsList.add(
                        Sponsor.fromJson(Map.from(map[sponsorCategory][j])));
                    count++;
                  }
                }
                if (sponsorsList.length < 1) {
                  return Center(
                    child: Text(Devfest.comingSoonText),
                  );
                }
                return ListView.builder(
                  itemCount: count,
                  itemBuilder: (BuildContext context, int i) {
                    return SponsorImage(
                      imgUrl: sponsorsList[i].image,
                      url: sponsorsList[i].url,
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class SponsorImage extends StatelessWidget {
  final String imgUrl;
  final String url;

  const SponsorImage({Key key, this.imgUrl, this.url}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launch(url);
      },
      child: Card(
        color: Colors.transparent,
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            height: 200.0,
            width: 200.0,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
