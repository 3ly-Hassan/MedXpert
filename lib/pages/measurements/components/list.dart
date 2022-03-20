// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:final_pro/models/measurement.dart';
import 'package:flutter/material.dart';

class MeasurmentsList extends StatefulWidget {
  late final List<Measurement> measurments;

  MeasurmentsList({Key? key, required this.measurments}) : super(key: key);

  @override
  State<MeasurmentsList> createState() => _MeasurmentsListState(measurments);
}

class _MeasurmentsListState extends State<MeasurmentsList> {
  late final List<Measurement> measurement;
  _MeasurmentsListState(this.measurement);
  @override
  Widget build(BuildContext context) {
    // print(measurement);
    return ListView(
      restorationId: 'list_demo_list_view',
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        for (int index = 0; index < measurement.length; index++)
          ListTile(
              leading: ExcludeSemantics(
                child: CircleAvatar(child: Text('$index')),
              ),
              title: Text('${measurement[index].id}'))
      ],
    );
  }
}
