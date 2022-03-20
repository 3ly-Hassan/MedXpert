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


  Widget elemet(int index, String name,  dynamic value) {
    return  ListTile(
                leading: ExcludeSemantics(
                  child: CircleAvatar(child: Text('$index'), backgroundColor: Colors.green,),
                ),
                title: Text("$name", style: TextStyle(color: Colors.white, fontSize: 22),),
                subtitle: Text('$value',style: TextStyle(color: Colors.white),),
                
                );
  }


  Widget oneMeasurement(Measurement measurement, int index) {
    return Card(
  color: Colors.grey[900],
  shape: RoundedRectangleBorder(
    side: BorderSide(color: Colors.white70, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  margin: EdgeInsets.all(20.0),
  
  child: Container(
    child: Column(
        children: <Widget>[
            Text("Measurement $index", style: TextStyle(fontSize: 40, color: Colors.greenAccent) ,),
            elemet(0, "condition", measurement.condition),
            
            elemet(1, "pulse", measurement.pulse),

            elemet(2, "pressure", measurement.pressure),

            elemet(3, "respration", measurement.respration),

            elemet(4, "temperature", measurement.temp),

            elemet(5, "weight", measurement.weight)


          
        ],
    ),
  ),
);
  }

  Widget build(BuildContext context) {
    // print(measurement);
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < measurement.length;  i++)
          oneMeasurement(measurement[i], i)

          
        ],
      ),
    );
  }
}
