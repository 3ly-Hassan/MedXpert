import 'package:final_pro/pages/add_measurement/addMeasurements.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EmptyMeasurements extends StatelessWidget {
  const EmptyMeasurements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LineAwesomeIcons.plus_circle,
            size: 200,
            color: Colors.black26,
          ),
          Text(
            'No measurements yet',
            style: TextStyle(fontSize: 24),
          ),
          Text(
            'Let\'s Add One',
            style: TextStyle(fontSize: 24),
          ),
          SizedBox(
            height: 60,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddMeasurements.routeName);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.greenAccent,
              fixedSize: const Size(300, 70),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            child: Text(
              'Let\'s Add One',
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
