import 'dart:io';
import 'dart:ui' as ui;

import 'package:final_pro/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class Scan extends StatelessWidget {
  Scan({Key? key}) : super(key: key);
  static String routeName = "/scan";
  XFile? image;
  File? resizedImage;
  bool height = false;
  bool width = false;
  bool height_Width = false;
  late int h;
  late int w;

  // Color white = Colors.white.opacity(.5);

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
      } else if (state is SendWordError) {
        showToast(
            text: 'Error occurred when send the word',
            state: ToastStates.ERROR);
      } else if (state is SendWordSuccess) {
        showToast(text: 'word send Successfully', state: ToastStates.SUCCESS);
      }
    }, builder: (context, state) {
      if (state is ScanLoading) {
        return WillPopScope(
            onWillPop: () {
              height = false;
              width = false;
              height_Width = false;
              MeasurementCubit.get(context).goToInit();
              Navigator.pop(context, false);
              //we need to return a future
              return Future.value(false);
            },
            child: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ));
      } else if (state is ScanSuccess &&
          MeasurementCubit.get(context).words.data!.isNotEmpty) {
        return SafeArea(
          child: WillPopScope(
            onWillPop: () {
              height = false;
              width = false;
              height_Width = false;
              MeasurementCubit.get(context).goToInit();
              Navigator.pop(context, false);
              //we need to return a future
              return Future.value(false);
            },
            child: Scaffold(
              body: resizedImage == null
                  ? Stack(
                      children: [
                        Image.file(File(
                          image!.path,
                        )),
                        ...MeasurementCubit.get(context).words.data!.map((e) =>
                            Positioned(
                              left: double.parse(e.vertices![0].x.toString()),
                              top: double.parse(e.vertices![0].y.toString()),
                              child: e.names!.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('cancel'))
                                                ],
                                                content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: e.names!
                                                        .map((z) => TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              MeasurementCubit
                                                                      .get(
                                                                          context)
                                                                  .sendWord(
                                                                      MeasurementCubit.get(
                                                                              context)
                                                                          .words
                                                                          .imgName,
                                                                      e.vertices,
                                                                      z);
                                                            },
                                                            child: Text(z)))
                                                        .toList()),
                                                title: Text(
                                                    'Help us to improve it'),
                                              );
                                            });
                                      },
                                      child: Container(
                                        constraints: BoxConstraints(
                                                minHeight: 30, minWidth: 20)
                                            .normalize(),
                                        color: Colors.white,
                                        child:
                                            FittedBox(child: Text(e.names![0])),
                                        width: (double.parse(e.vertices![1].x
                                                    .toString()) -
                                                double.parse(e.vertices![0].x
                                                    .toString())) -
                                            5,
                                        height: (double.parse(e.vertices![3].y
                                                    .toString()) -
                                                double.parse(e.vertices![0].y
                                                    .toString())) -
                                            15,
                                      ),
                                    )
                                  : SizedBox(),
                            ))
                      ],
                    )
                  : height
                      ? Stack(
                          children: [
                            Image.file(
                              File(
                                resizedImage!.path,
                              ),
                              height: MediaQuery.of(context).size.height,
                              width: w.toDouble(),
                            ),
                            ...MeasurementCubit.get(context)
                                .words
                                .data!
                                .map((e) => Positioned(
                                      left: double.parse(
                                          e.vertices![0].x.toString()),
                                      top: double.parse(
                                          e.vertices![0].y.toString()),
                                      child: e.names!.isNotEmpty
                                          ? InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        actions: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'cancel'))
                                                        ],
                                                        content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: e.names!
                                                                .map((z) =>
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          MeasurementCubit.get(context).sendWord(
                                                                              MeasurementCubit.get(context).words.imgName,
                                                                              e.vertices,
                                                                              z);
                                                                        },
                                                                        child: Text(
                                                                            z)))
                                                                .toList()),
                                                        title: Text(
                                                            'Help us to improve it'),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                constraints: BoxConstraints(
                                                        minHeight: 30,
                                                        minWidth: 20)
                                                    .normalize(),
                                                color: Colors.white,
                                                child: FittedBox(
                                                    child: Text(e.names![0])),
                                                width: (double.parse(e
                                                            .vertices![1].x
                                                            .toString()) -
                                                        double.parse(e
                                                            .vertices![0].x
                                                            .toString())) -
                                                    5,
                                                height: (double.parse(e
                                                            .vertices![3].y
                                                            .toString()) -
                                                        double.parse(e
                                                            .vertices![0].y
                                                            .toString())) -
                                                    15,
                                              ),
                                            )
                                          : SizedBox(),
                                    ))
                          ],
                        )
                      : width
                          ? Stack(
                              children: [
                                Image.file(
                                  File(
                                    resizedImage!.path,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  height: h.toDouble(),
                                ),
                                ...MeasurementCubit.get(context)
                                    .words
                                    .data!
                                    .map((e) => Positioned(
                                          left: double.parse(
                                              e.vertices![0].x.toString()),
                                          top: double.parse(
                                              e.vertices![0].y.toString()),
                                          child: e.names!.isNotEmpty
                                              ? InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'cancel'))
                                                            ],
                                                            content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: e
                                                                    .names!
                                                                    .map((z) =>
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              MeasurementCubit.get(context).sendWord(MeasurementCubit.get(context).words.imgName, e.vertices, z);
                                                                            },
                                                                            child:
                                                                                Text(z)))
                                                                    .toList()),
                                                            title: Text(
                                                                'Help us to improve it'),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                            minHeight: 30,
                                                            minWidth: 20)
                                                        .normalize(),
                                                    color: Colors.white,
                                                    child: FittedBox(
                                                        child:
                                                            Text(e.names![0])),
                                                    width: (double.parse(e
                                                                .vertices![1].x
                                                                .toString()) -
                                                            double.parse(e
                                                                .vertices![0].x
                                                                .toString())) -
                                                        5,
                                                    height: (double.parse(e
                                                                .vertices![3].y
                                                                .toString()) -
                                                            double.parse(e
                                                                .vertices![0].y
                                                                .toString())) -
                                                        15,
                                                  ),
                                                )
                                              : SizedBox(),
                                        ))
                              ],
                            )
                          : Stack(
                              children: [
                                Image.file(
                                  File(
                                    resizedImage!.path,
                                  ),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                                ...MeasurementCubit.get(context)
                                    .words
                                    .data!
                                    .map((e) => Positioned(
                                          left: double.parse(
                                              e.vertices![0].x.toString()),
                                          top: double.parse(
                                              e.vertices![0].y.toString()),
                                          child: e.names!.isNotEmpty
                                              ? InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            actions: [
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'cancel'))
                                                            ],
                                                            content: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: e
                                                                    .names!
                                                                    .map((z) =>
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              MeasurementCubit.get(context).sendWord(MeasurementCubit.get(context).words.imgName, e.vertices, z);
                                                                            },
                                                                            child:
                                                                                Text(z)))
                                                                    .toList()),
                                                            title: Text(
                                                                'Help us to improve it'),
                                                          );
                                                        });
                                                  },
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                            minHeight: 30,
                                                            minWidth: 20)
                                                        .normalize(),
                                                    color: Colors.white,
                                                    child: FittedBox(
                                                        child:
                                                            Text(e.names![0])),
                                                    width: (double.parse(e
                                                                .vertices![1].x
                                                                .toString()) -
                                                            double.parse(e
                                                                .vertices![0].x
                                                                .toString())) -
                                                        5,
                                                    height: (double.parse(e
                                                                .vertices![3].y
                                                                .toString()) -
                                                            double.parse(e
                                                                .vertices![0].y
                                                                .toString())) -
                                                        15,
                                                  ),
                                                )
                                              : SizedBox(),
                                        ))
                              ],
                            ),
            ),
          ),
        );
      }
      return WillPopScope(
        onWillPop: () {
          height = false;
          width = false;
          height_Width = false;
          MeasurementCubit.get(context).goToInit();
          Navigator.pop(context, false);
          //we need to return a future
          return Future.value(false);
        },
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    ImageProperties prop =
                        await FlutterNativeImage.getImageProperties(
                            image!.path);
                    if (prop.height! > MediaQuery.of(context).size.height &&
                        prop.width! <= MediaQuery.of(context).size.width) {
                      height = true;
                      w = prop.width!;
                      print('height');
                      print(prop.height);
                      print(prop.width);
                      resizedImage = await FlutterNativeImage.compressImage(
                          image!.path,
                          quality: 100,
                          targetHeight:
                              MediaQuery.of(context).size.height.toInt(),
                          targetWidth: prop.width!);
                      MeasurementCubit.get(context)
                          .createScan(resizedImage!.path, image!.name);
                    } else if (prop.width! >
                            MediaQuery.of(context).size.width &&
                        prop.height! <= MediaQuery.of(context).size.height) {
                      width = true;
                      h = prop.height!;
                      print('width');
                      print(prop.height);
                      print(prop.width);
                      resizedImage = await FlutterNativeImage.compressImage(
                          image!.path,
                          quality: 100,
                          targetWidth:
                              MediaQuery.of(context).size.width.toInt(),
                          targetHeight: prop.height!);
                      MeasurementCubit.get(context)
                          .createScan(resizedImage!.path, image!.name);
                    } else if (prop.width! >
                            MediaQuery.of(context).size.width &&
                        prop.height! > MediaQuery.of(context).size.height) {
                      print('height_width');

                      height_Width = true;
                      resizedImage = await FlutterNativeImage.compressImage(
                          image!.path,
                          quality: 100,
                          targetHeight:
                              MediaQuery.of(context).size.height.toInt(),
                          targetWidth:
                              MediaQuery.of(context).size.width.toInt());
                      MeasurementCubit.get(context)
                          .createScan(resizedImage!.path, image!.name);
                    } else {
                      print('nothing');
                      print(prop.height);
                      print(prop.width);

                      MeasurementCubit.get(context)
                          .createScan(image!.path, image!.name);
                    }
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
                    image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
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
        ),
      );
    });
  }

  void paint(Canvas canvas, Size size) {
    var center = size / 2;
    var style = TextStyle();

    final ui.ParagraphBuilder paragraphBuilder =
        ui.ParagraphBuilder(ui.ParagraphStyle(
      fontSize: style.fontSize,
      fontFamily: style.fontFamily,
      fontStyle: style.fontStyle,
      fontWeight: style.fontWeight,
      textAlign: TextAlign.justify,
    ))
          ..pushStyle(style.getTextStyle())
          ..addText('Demo Text');
    final ui.Paragraph paragraph = paragraphBuilder.build()
      ..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, Offset(center.width, center.height));
  }
}
