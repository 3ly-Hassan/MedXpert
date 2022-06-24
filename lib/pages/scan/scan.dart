import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubits/MeasuremetCubit/measurement_cubit.dart';

class Scan extends StatelessWidget {
  const Scan({Key? key}) : super(key: key);
  static String routeName = "/scan";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () async {
                print('mmmm');
                XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                MeasurementCubit.get(context)
                    .createScan(image!.path, image.name);
                print(image.path);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green.withOpacity(.7),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 40,
                      ),
                      Text(
                        'Choose From Gallery',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 28),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                XFile? image =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                MeasurementCubit.get(context)
                    .createScan(image!.path, image.name);
                print(image.path);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.yellow.withOpacity(.7),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 40,
                      ),
                      Text(
                        'Camera',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 28),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
