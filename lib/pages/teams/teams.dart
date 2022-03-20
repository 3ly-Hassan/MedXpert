import 'package:flutter/material.dart';
import 'components/body.dart';

class Teams extends StatelessWidget {
  static String routeName = "/teams";

  const Teams({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Teams"),
        ),
        body: Body());
  }
}
