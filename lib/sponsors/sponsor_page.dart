import 'package:cached_network_image/cached_network_image.dart';
import 'package:devfest_gandhinagar/home/sponsor.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorPage extends StatelessWidget {
  static const String routeName = "/sponsor";
  static List<Sponsor> sponsorsList = new List<Sponsor>();

  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("sponsors").getDocuments(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text("Unknown Error: ${snapshot.error}"),
            );
          } else {
            for (int i = 0; i < snapshot.data.documents.length; i++) {
              sponsorsList
                  .add(Sponsor.fromJson(snapshot.data.documents[i].data));
            }
            return DevScaffold(
              title: "Sponsors",
              body: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int i) {
                  return SponsorImage(
                    imgUrl: sponsorsList[i].logo,
                    url: sponsorsList[i].redirectUrl,
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
