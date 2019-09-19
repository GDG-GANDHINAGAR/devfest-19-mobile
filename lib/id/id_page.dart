import 'package:devfest_gandhinagar/config/index.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:devfest_gandhinagar/utils/devfest.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class IDPage extends StatelessWidget {
  static const String routeName = "/id";
  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      title: "Your ID",
      body: Container(
        color: ConfigBloc().darkModeOn ? Colors.grey[800] : Colors.white,
        // decoration: BoxDecoration(
        // border: Border.all(),
        // borderRadius: BorderRadius.all(Radius.circular(50)), //
        // ),
        // padding: EdgeInsets.all(2),
        child: Stack(
          // fit: StackFit.,
          children: <Widget>[
            Positioned(
              // top: -1 * MediaQuery.of(context).size.height * 0.07,
              // right: -1 * MediaQuery.of(context).size.width * 0.08,
              // width: MediaQuery.of(context).size.width * 1.1,
              // child: Image.asset("assets/images/id_card/Asset 15@4x.png"),
              child: CustomPaint(
                painter: BGCircle(
                  xCircle: MediaQuery.of(context).size.width / 100,
                  yCircle: -1 * MediaQuery.of(context).size.height / 3.5,
                  radius: MediaQuery.of(context).size.height / 1.5,
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.4,
              top: -1 * MediaQuery.of(context).size.height * 0.08,
              right: -1 * MediaQuery.of(context).size.width * 0.28,
              child: Image.asset("assets/images/id_card/Asset 1@4x.png"),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.1,
              right: MediaQuery.of(context).size.width * 0.22,
              child: Image.asset("assets/images/id_card/Asset 3@4x.png"),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.23,
              top: -1 * MediaQuery.of(context).size.height * 0.085,
              left: MediaQuery.of(context).size.width * 0.07,
              child: Image.asset("assets/images/id_card/Asset 9@4x.png"),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.18,
              left: MediaQuery.of(context).size.width * 0.78,
              child: Image.asset("assets/images/id_card/Asset 4@4x.png"),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.03,
              top: MediaQuery.of(context).size.height * 0.18,
              left: MediaQuery.of(context).size.width * 0.163,
              child: Image.asset("assets/images/id_card/Asset 7@4x.png"),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.25,
              left: -1 * MediaQuery.of(context).size.width * 0.03,
              child: Image.asset("assets/images/id_card/Asset 5@4x.png"),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.015,
              top: MediaQuery.of(context).size.height * 0.06,
              right: MediaQuery.of(context).size.width * 0.177,
              child: Image.asset("assets/images/id_card/Asset 7@4x.png"),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width * 0.08,
              top: MediaQuery.of(context).size.height * 0.1,
              left: -1 * MediaQuery.of(context).size.width * 0.02,
              child: Image.asset("assets/images/id_card/Asset 8@4x.png"),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/devfest_logo_dark.png",
                      scale: 1.7,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 75,
                      child:
                          Image.asset("assets/images/id_card/Asset 10@4x.png"),
                      backgroundImage: NetworkImage(
                          Devfest.prefs.getString(Devfest.photoPref)),
                    ),
                  ],
                ),
                Text(
                  Devfest.prefs.getString(Devfest.displayNamePref),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 4),
                      child:
                          Image.asset("assets/images/id_card/Asset 13@4x.png"),
                    ),
                    QrImage(
                      backgroundColor: Colors.white,
                      size: MediaQuery.of(context).size.width / 3,
                      data: Devfest.prefs.getString(Devfest.uidPref),
                      version: QrVersions.auto,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 4),
                      child:
                          Image.asset("assets/images/id_card/Asset 14@4x.png"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("#GDGDevFest"),
                    SizedBox(
                      height: 5,
                    ),
                    Text("#DevFestGandinagar"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BGCircle extends CustomPainter {
  double xCircle, yCircle, radius;
  BGCircle(
      {@required this.xCircle, @required this.yCircle, @required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.black;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1;

    canvas.drawCircle(
      Offset(xCircle, yCircle),
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
