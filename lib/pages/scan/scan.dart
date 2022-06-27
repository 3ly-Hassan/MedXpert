import 'dart:io';

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
        return WillPopScope(
             onWillPop: () {
              height=false;
              width=false;
              height_Width=false;
        MeasurementCubit.get(context).goToInit();
        Navigator.pop(context, false);
        //we need to return a future
        return Future.value(false);
             },child:Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ));
      } else if (state is ScanSuccess &&
          MeasurementCubit.get(context).words.data!.isNotEmpty) {
        return SafeArea(
          child: WillPopScope(
             onWillPop: () {
               height=false;
              width=false;
              height_Width=false;
        MeasurementCubit.get(context).goToInit();
        Navigator.pop(context, false);
        //we need to return a future
        return Future.value(false);
             },
            child: Scaffold(
              body:resizedImage==null?Stack(
                children: [
                  Image.file(File(image!.path,)),
                  ...MeasurementCubit.get(context).words.data!.map(
                        (e) => Positioned(
                          left: double.parse(e.vertices![0].x.toString()),
                          top: double.parse(e.vertices![0].y.toString()),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 60,minWidth: 80).normalize(),
                            color: Colors.white,
                            child:FittedBox(child: Text(e.names![0])),
                            width: (double.parse(e.vertices![1].x.toString())-double.parse(e.vertices![0].x.toString())),
                            height: (double.parse(e.vertices![3].y.toString())-double.parse(e.vertices![0].y.toString())),
                        ),)
                      )
                ],
              ):height?Stack(
                children: [
                  Image.file(File(resizedImage!.path,),height: MediaQuery.of(context).size.height),
                  ...MeasurementCubit.get(context).words.data!.map(
                        (e) => Positioned(
                          left: double.parse(e.vertices![0].x.toString()),
                          top: double.parse(e.vertices![0].y.toString()),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 60,minWidth: 80).normalize(),
                            color: Colors.white,
                            child:FittedBox(child: Text(e.names![0])),
                            width: (double.parse(e.vertices![1].x.toString())-double.parse(e.vertices![0].x.toString())),
                            height: (double.parse(e.vertices![3].y.toString())-double.parse(e.vertices![0].y.toString())),
                        ),)
                      )
                ],
              ):width?Stack(
                children: [
                  Image.file(File(resizedImage!.path,),width:MediaQuery.of(context).size.width),
                  ...MeasurementCubit.get(context).words.data!.map(
                        (e) => Positioned(
                          left: double.parse(e.vertices![0].x.toString()),
                          top: double.parse(e.vertices![0].y.toString()),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 60,minWidth: 80).normalize(),
                            color: Colors.white,
                            child:FittedBox(child: Text(e.names![0])),
                            width: (double.parse(e.vertices![1].x.toString())-double.parse(e.vertices![0].x.toString())),
                            height: (double.parse(e.vertices![3].y.toString())-double.parse(e.vertices![0].y.toString())),
                        ),)
                      )
                ],
              ):Stack(
                children: [
                  Image.file(File(resizedImage!.path,),height: MediaQuery.of(context).size.height,width:MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                  ...MeasurementCubit.get(context).words.data!.map(
                        (e) => Positioned(
                          left: double.parse(e.vertices![0].x.toString()),
                          top: double.parse(e.vertices![0].y.toString()),
                          child: Container(
                            constraints: BoxConstraints(minHeight: 60,minWidth: 80).normalize(),
                            color: Colors.white,
                            child:FittedBox(child: Text(e.names![0])),
                            width: (double.parse(e.vertices![1].x.toString())-double.parse(e.vertices![0].x.toString())),
                            height: (double.parse(e.vertices![3].y.toString())-double.parse(e.vertices![0].y.toString())),
                        ),)
                      )
                ],
              ),
            ),
          ),
        );
      }
      return WillPopScope(
        onWillPop: () {
           height=false;
              width=false;
              height_Width=false;
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
                       ImageProperties prop = await FlutterNativeImage.getImageProperties(image!.path);
                       if(prop.height!>MediaQuery.of(context).size.height)
                       {
                        height = true;
                        print('height');
                        print(prop.height);
                          print(prop.width);
                        resizedImage = await FlutterNativeImage.compressImage(image!.path,quality: 100,targetHeight: MediaQuery.of(context).size.height.toInt());
                        MeasurementCubit.get(context)
                        .createScan(resizedImage!.path,image!.name);
                       }
                       else if(prop.width!>MediaQuery.of(context).size.width)
                       {
                        width = true;
                        print('width');

                        resizedImage = await FlutterNativeImage.compressImage(image!.path,quality: 100,targetWidth:MediaQuery.of(context).size.width.toInt() );
                        MeasurementCubit.get(context)
                        .createScan(resizedImage!.path,image!.name);

                       }
                       else if(prop.width!>MediaQuery.of(context).size.width&&prop.height!>MediaQuery.of(context).size.height)
                       {
                        print('height_width');

                        height_Width = true;
                        resizedImage = await FlutterNativeImage.compressImage(image!.path,quality: 100,targetHeight: MediaQuery.of(context).size.height.toInt(),targetWidth:MediaQuery.of(context).size.width.toInt() );
                        MeasurementCubit.get(context)
                        .createScan(resizedImage!.path,image!.name);
                       }
                       else
                       {
                        print('nothing');
                          print(prop.height);
                          print(prop.width);

 MeasurementCubit.get(context)
                        .createScan(image!.path,image!.name);
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
        ),
      );
    });
  }
}
