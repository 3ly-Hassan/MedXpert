import 'package:final_pro/components/dashBord_item.dart';
import 'package:final_pro/enums.dart';
import 'package:flutter/material.dart';

class ChooseWho extends StatelessWidget {
  final choose = Who.guest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            'Who are You ? ...',
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.w900, fontSize: 22),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                DashBordItem(
                    image: 'assets/images/patient.jpg', title: 'Patient'),
                Spacer(),
                DashBordItem(
                    image: 'assets/images/doctor.jpg', title: 'Doctor'),
              ],
            ),
          ),
          DashBordItem(image: 'assets/images/com.jpg', title: 'Company'),
          TextButton(onPressed: () {}, child: Text('continue as a guest..'))
        ],
      ),
    );
  }
}
