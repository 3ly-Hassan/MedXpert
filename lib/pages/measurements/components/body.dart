import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../models/measurement.dart';
import '../../../cubits/MeasuremetCubit/measurement_cubit.dart';

class Body extends StatelessWidget {
  final len;
  final measurements;
  final expanded;

  const Body({Key? key, this.len, this.measurements, this.expanded})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return item(measurements[index], index, context);
      },
      itemCount: len,
    );
  }

  Widget item(Measurement measurement, int i, context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Dismissible(
            background: Container(
              color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Take Care'),
                      content: const Text('Are you sure you want to wipe it?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            MeasurementCubit.get(context)
                                .deleteMeasurement(measurement.id!);
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('no'),
                        )
                      ],
                    );
                  });
            },
            child: ListTile(
              title: Text(
                getText(i),
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
              ),
              subtitle: Text(
                measurement.createdAt == null
                    ? measurement.fakeDate!
                    : measurement.createdAt!.substring(0, 10),
                style: TextStyle(color: Colors.amber),
              ),
              tileColor: Colors.green,
              trailing: IconButton(
                icon: Icon(
                  Icons.expand_more,
                  color: Colors.amber,
                  size: 35,
                ),
                onPressed: () {
                  MeasurementCubit.get(context).invertExpand(i);
                },
              ),
            ),
          ),
          expanded.contains(i) ? expandedContainer(measurement) : Container(),
        ],
      ),
    );
  }

  getColor(int i) {
    var color;
    switch (i) {
      case 0:
        color = Colors.green;
        break;
      case 1:
        color = Colors.amber.shade500;
        break;
      case 2:
        color = Colors.green.shade300;
        break;
      case 3:
        color = Colors.green.shade200;
        break;
      case 4:
        color = Colors.green.shade100;
        break;
    }
    return color;
  }

  getText(int i) {
    var text;
    switch (i) {
      case 0:
        text = 'The Newest One';
        break;
      case 1:
      case 2:
      case 3:
      case 4:
        text = 'recently measured ';
        break;
    }
    return text;
  }

  Widget expandedContainer(Measurement m) {
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
                  buildTextContainer('The Condition', m.condition),
                  m.pressure != null
                      ? buildTextContainer('The Blood Pressure', m.pressure)
                      : Container(),
                  m.pulse != null
                      ? buildTextContainer('The Pulse Rate', m.pulse)
                      : Container(),
                  m.respration != null
                      ? buildTextContainer('The Respiration', m.respration)
                      : Container(),
                  m.temp != null
                      ? buildTextContainer('The Temperature', m.temp)
                      : Container(),
                  m.weight != null
                      ? buildTextContainer('The Weight', m.weight)
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildTextContainer(constant, text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            '$constant : $text',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
        Divider(
          height: 1,
          color: Colors.white,
        )
      ],
    );
  }
}
