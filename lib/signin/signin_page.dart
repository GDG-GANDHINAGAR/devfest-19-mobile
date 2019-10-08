import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_gandhinagar/home/home_page.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:devfest_gandhinagar/utils/devfest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.none) {
          return SpinKitChasingDots(
            color: Colors.red,
          );
        } else {
          if (snapshot.hasData) {
            return HomePage();
          }
          return DevScaffold(
            title: "Sign In",
            body: Stack(
              children: <Widget>[
                Positioned(
                  child: Image.asset("assets/images/doodles/Ellipse 101.png"),
                  bottom: MediaQuery.of(context).size.height / 4.7,
                  right: -1 * MediaQuery.of(context).size.width / 20,
                ),
                Positioned(
                  child: Image.asset("assets/images/doodles/Ellipse 107.png"),
                  right: MediaQuery.of(context).size.width / 12,
                  top: MediaQuery.of(context).size.height / 3.3,
                ),
                Positioned(
                  child: Image.asset("assets/images/doodles/Group 60.png"),
                  left: -1 * MediaQuery.of(context).size.width / 40,
                  top: MediaQuery.of(context).size.height / 3,
                ),
                Positioned(
                  child: Image.asset("assets/images/doodles/Group 61.png"),
                  top: MediaQuery.of(context).size.height / 30,
                  right: MediaQuery.of(context).size.width / 1.12,
                ),
                Positioned(
                  child: Image.asset("assets/images/doodles/Path 112.png"),
                  left: MediaQuery.of(context).size.width / 1.1,
                ),
                Positioned(
                  child: Image.asset("assets/images/doodles/Path 127.png"),
                  top: MediaQuery.of(context).size.height / 1.7,
                  right: MediaQuery.of(context).size.width / 1.09,
                ),
                Positioned(
                  child: Image.asset("assets/images/doodles/Path 133.png"),
                  top: MediaQuery.of(context).size.height / 1.28,
                  left: MediaQuery.of(context).size.width / 1.2,
                ),
                Positioned(
                  child: Image.asset("assets/images/doodles/Path 134.png"),
                  top: MediaQuery.of(context).size.height / 1.28,
                  right: MediaQuery.of(context).size.width / 1.25,
                ),
                Positioned(
                  child: Image.asset("assets/images/doodles/Path 135.png"),
                  bottom: MediaQuery.of(context).size.height / 1.24,
                  left: MediaQuery.of(context).size.width / 2,
                ),
                Positioned(
                  child: Image.asset("assets/images/doodles/Path 136.png"),
                  top: MediaQuery.of(context).size.height / 1.25,
                  left: MediaQuery.of(context).size.width / 2.5,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      Image.asset(
                        Devfest.prefs.getBool(Devfest.darkModePref) ?? false
                            ? "assets/images/devfest_logo_dark.png"
                            : "assets/images/devfest_logo_light.png",
                        scale: 1.15,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      Image.asset(
                        "assets/images/google_logo.png",
                        scale: 1.9,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 25,
                      ),
                      OutlineButton(
                        borderSide: BorderSide(
                          color: Devfest.prefs.getBool(Devfest.darkModePref) ??
                                  false
                              ? Colors.white
                              : Colors.grey,
                        ),
                        highlightedBorderColor: Colors.transparent,
                        highlightColor: Colors.green,
                        highlightElevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          // side: BorderSide(
                          //   color: Devfest.prefs.getBool(Devfest.darkModePref)
                          //       ? Colors.white
                          //       : Colors.grey,
                          // ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 6,
                          ),
                          child: Text(
                            "Sign In",
                            textScaleFactor: 1.4,
                            style: TextStyle(),
                          ),
                        ),
                        onPressed: () async {
                          FirebaseUser user = await _handleGoogleSignIn();
                          setBasicData(user);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<FirebaseUser> _handleGoogleSignIn() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    AuthResult authResult = await _auth.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    return user;
  }

  void setBasicData(FirebaseUser user) async {
    Devfest.prefs.setString(Devfest.displayNamePref, user.displayName);
    Devfest.prefs.setString(Devfest.emailPref, user.email);
    Devfest.prefs.setString(Devfest.uidPref, user.uid);
    Devfest.prefs.setString(Devfest.photoPref, user.photoUrl);

    await Firestore.instance.collection('users').document(user.email).setData(
      {
        "display_name": user.displayName,
        "email": user.email,
        "uid": user.uid,
        "photo_url": user.photoUrl,
      },
    );
  }
}
