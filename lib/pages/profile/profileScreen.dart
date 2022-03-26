import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/MeasuremetCubit/measurement_cubit.dart';
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
    var model = cubit.patient;
    nameController.text = model.username!;
    emailController.text = model.email!;
    birthController.text = model.birthDate!.substring(0, 10);
    weightController.text = model.weight == null ? '' : model.weight.toString();
    return BlocConsumer<MeasurementCubit, MeasurementState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: cubit.readOnly ? Text('Profile') : Text('Edit Profile'),
            actions: [
              IconButton(
                  onPressed: cubit.readOnly
                      ? () {
                          cubit.toggleReadOnly();
                        }
                      : () {
                          var patient = Patient();
                          patient.birthDate = birthController.text;
                          patient.email = emailController.text;
                          patient.username = nameController.text;
                          patient.weight = num.tryParse(weightController.text);
                          patient.gender = cubit.genderVal;
                          cubit.updatePatientProfile(patient);
                          cubit.toggleReadOnly();
                        },
                  icon: cubit.readOnly ? Icon(Icons.edit) : Icon(Icons.save)),
              !cubit.readOnly
                  ? TextButton(
                      onPressed: () {
                        nameController.text = model.username!;
                        emailController.text = model.email!;
                        birthController.text =
                            model.birthDate!.substring(0, 10);
                        cubit.toggleReadOnly();
                      },
                      child: Text(
                        'cancel',
                        style: TextStyle(
                            color: Colors.red,
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
