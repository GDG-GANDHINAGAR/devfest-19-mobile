import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_gandhinagar/home/home_page.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';
import 'package:devfest_gandhinagar/utils/devfest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            body: Center(
              child: RaisedButton(
                child: Text("Sign In"),
                onPressed: () async {
                  FirebaseUser user = await _handleGoogleSignIn();
                  setBasicData(user);
                },
              ),
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
    await Firestore.instance.collection('users').document(user.uid).setData(
      {
        "display_name": user.displayName,
        "email": user.email,
        "uid": user.uid,
        "photo_url": user.photoUrl,
      },
    );
    Devfest.prefs.setString(Devfest.displayNamePref, user.displayName);
    Devfest.prefs.setString(Devfest.emailPref, user.email);
  }
}
