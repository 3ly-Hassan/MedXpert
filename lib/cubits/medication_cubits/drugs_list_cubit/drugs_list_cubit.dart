import 'package:final_pro/api_service/api_service.dart';
import 'package:final_pro/db_helper.dart';
import 'package:final_pro/models/notification_models/request_notification_model.dart';
import 'package:final_pro/models/notification_models/response_notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api_service/api_service.dart';
import '../../../constants.dart';
import '../../../date_helper.dart';
import '../../../models/medication.dart';
import '../../../models/medication_drug.dart';
import '../../../models/notification_models/local_notofocation_model.dart';
import '../../../notification_helper.dart';
import '../medications_list_cubit/medications_list_cubit.dart';

part 'drugs_list_state.dart';

class DrugsListCubit extends Cubit<DrugsListState> {
  DrugsListCubit() : super(DrugsListInitial());
  APIService apiService = APIService();

  bool isDeleted = false;
  Medication medicationItem = Medication();
  List drugs = [];

  getDrugsList(Medication medication) {
    medicationItem = medication;
    drugs = medicationItem.drugs!;
    emit(GetDrugsListState(drugs));
  }

  Future deleteDrug(String medicationId, String drugId, int index,
      BuildContext context) async {
    final packUp = drugs[index];
    drugs.removeAt(index);
    emit(GetDrugsListState(drugs));

    isDeleted = await apiService.deleteDrug(medicationId, drugId);

    if (!isDeleted) {
      drugs.insert(index, packUp);
      emit(DeletionFailedState());
    }
  }

  Future addDrugToMedication(
      String medicationId, MedicationDrug drug, BuildContext context) async {
    emit(DrugsListLoadingState());
    Medication? receivedMedication =
        await apiService.addDrugToMedication(medicationId, drug);

    if (receivedMedication != null) {
      medicationItem = receivedMedication;
      drugs = medicationItem.drugs!;

      //refresh drugs list
      emit(AddingDrugSuccessState(receivedMedication.drugs!));
      Navigator.of(context).pop();
      //refresh medication list with new added drug
      BlocProvider.of<MedicationsListCubit>(context).getMedicationsList();
    } else {
      emit(AddingDrugFailedState());
    }
  }

  Future toggleSwitch(
      context, bool value, String medicationId, String drugId) async {
    Medication? medication =
        await apiService.updateCurrentlyTaken(value, medicationId, drugId);
    if (medication != null) {
      getDrugsList(medication);
      //refresh medications_list_screen
      BlocProvider.of<MedicationsListCubit>(context).getMedicationsList();
    } else {
      emit(UpdateDrugFailedState());
    }
  }

  Future createNotification(
    BuildContext context,
    MedicationDrug medicationDrug,
  ) async {
    //
    List doseTimes = [];
    //
    final DateTime drugStartDate =
        DateHelper.parseDate(medicationDrug.startDate!, kFormattedString);
    final DateTime drugEndDate =
        DateHelper.parseDate(medicationDrug.endDate!, kFormattedString);
    //
    final bool isPastDate = DateHelper.isPastDate(drugEndDate);
    //
    if (isPastDate == true) {
      emit(DateIsPastState());
      return;
    }
    //
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: drugStartDate,
      firstDate: drugStartDate,
      lastDate: drugEndDate,
    );
    //
    //show time pickers based on number of doses
    if (pickedDate != null) {
      //
      for (int i = 0; i < medicationDrug.dose!; i++) {
        final TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: DateHelper.getNextHour(),
          confirmText: 'OK',
          cancelText: 'Skip',
          helpText: '${i + 1} dose',
        );

        if (pickedTime != null &&
            !DateHelper.isPastDateAndTime1(pickedDate, pickedTime)) {
          doseTimes.add(pickedTime);
        }
      }
      //
      //Create notifications and insert in DB
      //
      for (int i = 0; i < doseTimes.length; i++) {
        final int notificationId =
            await NotificationHelper.generateNotificationId(context);
        //
        //create notification using NotificationHelper
        await NotificationHelper.createNotification(
          notificationId: notificationId,
          title:
              '${medicationDrug.drugName!}      ${DateHelper.getFormattedStringForTime(context: context, time: doseTimes[i])}',
          body: 'Time to take the dose!',
          date: pickedDate,
          time: doseTimes[i],
          payLoad: 'payLoad',
        );
        //Add notification To the local dateBase
        final LocalNotificationModel notificationModel = LocalNotificationModel(
          notificationId: '$notificationId',
          drugUniqueId: medicationDrug.drugUniqueId!,
          drugName: medicationDrug.drugName!,
          date: DateHelper.getFormattedString(
              date: pickedDate, formattedString: kFormattedString),
          time: DateHelper.getFormattedStringForTime(
            context: context,
            time: doseTimes[i],
          ),
        );
        await DBHelper.insertValue(
          DBHelper.notificationTableName,
          notificationModel,
        );

        //let followers know about notification
        await apiService.sendLocalNotification(
          RequestNotificationModel(
              drugUniqueId: notificationModel.drugUniqueId,
              drugName: notificationModel.drugName,
              date: notificationModel.date,
              time: notificationModel.time),
        );
      }
      //emit appropriate states in UI
      emit(NotificationCreationState(
          doseTimes.length, medicationDrug.dose! - doseTimes.length));
    }
  }
}
