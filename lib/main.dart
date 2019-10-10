import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:devfest_gandhinagar/utils/dependency_injection.dart';
import 'package:devfest_gandhinagar/utils/devfest.dart';
import 'package:devfest_gandhinagar/utils/simple_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/config_page.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  //* Forcing only portrait orientation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // * Get Shared Preference Instance for whole app
  Devfest.prefs = await SharedPreferences.getInstance();

  //* To check the app is running in debug and set some variables for that
  Devfest.checkDebug();

  //* Time travel debugging to check app states
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // * Set flavor for your app. For eg - MOCK for offline, REST for some random server calls to your backend, FIREBASE for firebase calls
  Injector.configure(Flavor.MOCK);

  //* To check if the app is running on latest version
  DocumentSnapshot snapshot =
      await Firestore.instance.collection("homepage").document("data").get();

  // setting the default value of isUpdated to true
  // in case the app is offline and firestore fetch query fails
  if (snapshot.data["meta"]["app_version_code"] == Devfest.app_version_code ??
      true) {
    Devfest.prefs.setBool(Devfest.isUpdatedPref, true);
    print("Set isupdated bool to true");
  } else {
    Devfest.prefs.setBool(Devfest.isUpdatedPref, false);
    print("Set isupdated bool to false");
  }

  runApp(ConfigPage());
}
