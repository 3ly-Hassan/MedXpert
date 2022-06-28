import 'package:flutter/material.dart';

import '../../../models/patient.dart';

class ChronicCard extends StatelessWidget {
  final Chronics chronic;
  const ChronicCard({Key? key, required this.chronic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(chronic.chronicName!),
      subtitle: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("• Since: ${chronic.since!.substring(0, 10)}"),
            Text("• State: ${chronic.state!}"),
          ],
        ),
      ),
    );
  }
}
