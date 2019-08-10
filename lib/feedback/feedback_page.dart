import 'package:flutter/material.dart';
import 'package:devfest_gandhinagar/universal/dev_scaffold.dart';

class FeedbackPage extends StatefulWidget {
  static const String routeName = "/feedback";
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DevScaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Card(
              clipBehavior: Clip.hardEdge,
              child: Text(
                  "Looks like you made it to the end of the fest. Don't you deserve some Shwags!!"),
            )
          ],
        ),
      ),
      title: "Feedback",
    );
  }
}
