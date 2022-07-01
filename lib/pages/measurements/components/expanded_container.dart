import 'package:final_pro/models/measurement.dart';
import 'package:flutter/material.dart';

import 'build_text_container.dart';

class ExpandedContainer extends StatelessWidget {
  final Measurement m;
  const ExpandedContainer(this.m, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        ClipRRect(
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            child: ClipRRect(
              child: Column(
                children: [
                  BuildTextContainer('The Condition', m.condition),
                  m.systolicPressure != null
                      ? BuildTextContainer('The Blood Pressure',
                          '${m.systolicPressure}/${m.diastolicPressure}')
                      : Container(),
                  m.pulse != null
                      ? BuildTextContainer('The Pulse Rate', m.pulse)
                      : Container(),
                  m.respration != null
                      ? BuildTextContainer('The Respiration', m.respration)
                      : Container(),
                  m.sugar != null
                      ? BuildTextContainer('The Glucose', m.sugar)
                      : Container(),
                  m.oxegen != null
                      ? BuildTextContainer('The Oxygen', m.oxegen)
                      : Container(),
                  m.temp != null
                      ? BuildTextContainer('The Temperature', m.temp)
                      : Container(),
                  m.weight != null
                      ? BuildTextContainer('The Weight', m.weight)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
