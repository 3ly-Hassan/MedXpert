import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'loging.dart';

class NotVerified extends StatelessWidget {
  const NotVerified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LineAwesomeIcons.mail_bulk,
            size: 200,
            color: Colors.black26,
          ),
          Text(
            'you need to verify your email ',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            'Check your mail inbox',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 60,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, LoggingPage.routeName);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent,
              fixedSize: const Size(300, 70),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            child: Text(
              'Log In',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }
}
