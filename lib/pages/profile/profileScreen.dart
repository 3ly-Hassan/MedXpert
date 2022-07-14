import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
import 'package:final_pro/models/doctor.dart';
import 'package:final_pro/models/patient.dart';
import 'package:final_pro/pages/profile/components/profileBody.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static String routeName = "/profile";
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var birthController = TextEditingController();
  var weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var cubit = MeasurementCubit.get(context);
    var pModel = cubit.patient;
    var dModel = cubit.doctor;
    nameController.text =
        role == 'patient' ? pModel.username! : dModel.username!;
    emailController.text = role == 'patient' ? pModel.email! : dModel.email!;
    birthController.text = role == 'patient'
        ? pModel.birthDate!.substring(0, 10)
        : dModel.birthDate!.substring(0, 10);
    weightController.text =
        pModel.weight == null ? '' : pModel.weight.toString();
    return BlocConsumer<MeasurementCubit, MeasurementState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            backgroundColor: kAppBarColor,
            title: cubit.readOnly ? Text('Profile') : Text('Edit Profile'),
            actions: [
              IconButton(
                  onPressed: cubit.readOnly
                      ? () {
                          cubit.toggleReadOnly();
                        }
                      : role == 'patient'
                          ? () {
                              var patient = Patient();
                              patient.birthDate = birthController.text;
                              patient.email = emailController.text;
                              patient.username = nameController.text;
                              patient.weight =
                                  num.tryParse(weightController.text);
                              patient.gender = cubit.genderVal;
                              patient.residency = cubit.dropValue;
                              print(patient.residency.runtimeType);
                              cubit.updatePatientProfile(patient);
                              cubit.toggleReadOnly();
                            }
                          : () {
                              var doctor = Doctor();
                              doctor.birthDate = birthController.text;
                              print(birthController.text);
                              doctor.email = emailController.text;
                              doctor.username = nameController.text;
                              //patient.weight = num.tryParse(weightController.text);
                              doctor.gender = cubit.genderVal;
                              print(cubit.genderVal);
                              print(cubit.dropValue);
                              doctor.residency = cubit.dropValue;
                              print(doctor.residency.runtimeType);
                              cubit.updateDoctorProfile(doctor);
                              cubit.toggleReadOnly();
                            },
                  icon: cubit.readOnly
                      ? Icon(
                          Icons.edit,
                          color: Colors.white,
                        )
                      : Icon(Icons.save, color: Colors.white)),
              !cubit.readOnly
                  ? TextButton(
                      onPressed: () {
                        nameController.text = role == 'patient'
                            ? pModel.username!
                            : dModel.username!;
                        emailController.text =
                            role == 'patient' ? pModel.email! : dModel.email!;
                        birthController.text = role == 'patient'
                            ? pModel.birthDate!.substring(0, 10)
                            : dModel.birthDate!.substring(0, 10);
                        cubit.toggleReadOnly();
                      },
                      child: Text(
                        'cancel',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ))
                  : Container()
            ],
          ),
          body: ProfileBody(
            nameController: nameController,
            emailController: emailController,
            birthController: birthController,
            weightController: weightController,
          )),
    );
  }
}
