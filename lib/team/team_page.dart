import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/home/speaker.dart';
import 'package:devfest_gandhinagar/home/team.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:devfest_gandhinagar/utils/tools.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatelessWidget {
  static const String routeName = "/team";

  Widget socialActions(context) => FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                FontAwesomeIcons.facebookF,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].fbUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.twitter,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].twitterUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.linkedinIn,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].linkedinUrl);
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.github,
                size: 15,
              ),
              onPressed: () {
                launch(speakers[0].githubUrl);
              },
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    // var _homeBloc = HomeBloc();
    return DevScaffold(
      body: ListView.builder(
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
                        painter: GDGAvatar(),
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.yellow,
                          ),
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: CachedNetworkImageProvider(
                              // fit: BoxFit.fill,
                              teams[i].image,
                            ),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      // child: CachedNetworkImage(
                      //   fit: BoxFit.cover,
                      //   imageUrl: teams[i].image,
                      // ),
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
                                teams[i].name,
                                style: Theme.of(context).textTheme.title,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AnimatedContainer(
                                duration: Duration(seconds: 1),
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: 5,
                                color: Tools.multiColors[Random().nextInt(4)],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          socialActions(context),
                          Text(
                            teams[i].desc,
                            style: Theme.of(context).textTheme.subtitle,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            teams[i].contribution,
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          );
        },
        itemCount: teams.length,
      ),
      title: "Team",
    );
  }
}

class GDGAvatar extends CustomPainter {
  double x, y;
  Random random;

  GDGAvatar() {
    random = new Random();
  }

  double getXaxis(double width) {
    double value = width * random.nextDouble();
    return value;
  }

  double getYaxiz(double x, Size size) {
    final double r = (size.width / 2);
    final double g = (size.width / 2);
    final double h = (size.height / 2);
    y = random.nextBool()
        ? h + sqrt((pow(r, 2) - pow((x - g), 2)))
        : h - sqrt((pow(r, 2) - pow((x - g), 2)));
    return y;
  }

  
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.green;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    x = getXaxis(size.width);
    y = getYaxiz(x, size);

    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(x, y),
        height: 20,
        width: 20,
      ),
      paint,
    );

    x = getXaxis(size.width);
    y = getYaxiz(x, size);

    // print("y: $y");
    // print("x: $x");
    // print("g: $g");
    // print("h: $h");
    // print("r: $r");

    paint.color = Colors.blue;

    canvas.drawCircle(
      Offset(x, y),
      9,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
