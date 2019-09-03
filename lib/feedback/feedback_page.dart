import 'dart:math';
import 'package:devfest_gandhinagar/utils/devfest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfest_gandhinagar/dialogs/error_dialog.dart';
import 'package:devfest_gandhinagar/utils/tools.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';

class FeedbackPage extends StatefulWidget {
  static const String routeName = "/feedback";
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  Stream<DocumentSnapshot> _future;
  TextEditingController _feedbackControler = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  int _starRating = 5;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _future = Firestore.instance
        .collection("metadata")
        .document("feedback")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      title: "Feedback",
      body: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            StreamBuilder(
              stream: _future,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.none ||
                    snapshot.connectionState == ConnectionState.waiting) {
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
                        child: Text("Oops! Error Occured!"),
                      ),
                    );
                  } else {
                    return Card(
                      child: snapshot.data.data["feedback_active"]
                          ? feedbackActive()
                          : feedbackInactive(snapshot.data),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget feedbackActive() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: _starRowBuilder(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                child: TextFormField(
                  autocorrect: true,
                  controller: _feedbackControler,
                  maxLines: 5,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    hintText: "We'd love to hear from you !",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: _validateAndSave,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget feedbackInactive(DocumentSnapshot snapshot) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          "${snapshot.data["feedback_inactive_text"]}",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _starRowBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _starBuilder(1),
        _starBuilder(2),
        _starBuilder(3),
        _starBuilder(4),
        _starBuilder(5),
      ],
    );
  }

  Widget _starBuilder(int _starnumber) {
    return IconButton(
      onPressed: () {
        setState(() {
          _starRating = _starnumber;
        });
      },
      icon: _starnumber <= _starRating
          ? Icon(Icons.star, color: Color.fromARGB(255, 212, 175, 55))
          : Icon(Icons.star_border),
    );
  }

  void _validateAndSave() async {
    if (_formKey.currentState.validate() == true) {
      _formKey.currentState.save();

      await Firestore.instance
          .collection("feedbacks")
          .document(DateTime.now().millisecondsSinceEpoch.toString())
          .setData({
        "feedback": _feedbackControler.text,
        "name": Devfest.prefs.getString(Devfest.displayNamePref),
        "email": Devfest.prefs.getString(Devfest.emailPref),
        "time": DateTime.now().toIso8601String(),
        "stars": _starRating,
      });
      _feedbackControler.clear();
      _nameController.clear();
      Navigator.pop(context);
    } else {
      print("Form data NOT saved");
    }
  }
}
