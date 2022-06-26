import 'dart:io';

import 'package:final_pro/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubits/MeasuremetCubit/measurement_cubit.dart';

class Scan extends StatelessWidget {
  Scan({Key? key}) : super(key: key);
  static String routeName = "/scan";
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MeasurementCubit, MeasurementState>(
        listener: (context, state) {
      if (state is ScanError) {
        showToast(text: 'Error has occurred', state: ToastStates.ERROR);
      } else if (state is ScanSuccess &&
          MeasurementCubit.get(context).words.data!.isEmpty) {
        showToast(
            text: 'No drugs have been identified', state: ToastStates.WARNING);
      }
    }, builder: (context, state) {
      if (state is ScanLoading) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      } else if (state is ScanSuccess &&
          MeasurementCubit.get(context).words.data!.isNotEmpty) {
        return SafeArea(
          child: Scaffold(
            body: Stack(
              children: [
                Image.file(File(image!.path)),
                ...MeasurementCubit.get(context).words.data!.map(
                      (e) => Positioned(
                        left: double.parse(e.vertices![0].x.toString()),
                        top: double.parse(e.vertices![0].y.toString()),
                        child: Text(e.names![0]),
                      ),
                    )
              ],
            ),
          ),
        );
      }
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  MeasurementCubit.get(context)
                      .createScan(image!.path, image!.name);
                  print(image!.path);
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
                          style: const TextStyle(
                              color: Colors.black, fontSize: 28),
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
                  image =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  MeasurementCubit.get(context)
                      .createScan(image!.path, image!.name);
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
                          'Open The Camera',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 28),
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
    });
  }
}
