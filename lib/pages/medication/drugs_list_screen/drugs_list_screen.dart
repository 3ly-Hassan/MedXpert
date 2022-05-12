import 'package:final_pro/constants.dart';
import 'package:final_pro/date_helper.dart';
import 'package:final_pro/dialog_helper.dart';
import 'package:final_pro/models/medication.dart';
import 'package:final_pro/pages/teams/components/no_followers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../cubits/medication_cubits/drugs_list_cubit/drugs_list_cubit.dart';
import '../../../cubits/medication_cubits/medications_list_cubit/medications_list_cubit.dart';

class DrugsListScreen extends StatelessWidget {
  static String routeName = "/drug_list_screen";

  const DrugsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drugs list'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: BlocConsumer<DrugsListCubit, DrugsListState>(
        listener: (context, state) {
          if (state is DeletionFailedState) {
            showToast(text: 'Deletion failed', state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          Medication medication =
              BlocProvider.of<DrugsListCubit>(context).medicationItem;
          List drugsList = BlocProvider.of<DrugsListCubit>(context).drugs;
          return drugsList.isEmpty
              ? NoFollowersWidget(msg: 'No drugs!')
              : ListView.builder(
                  itemCount: drugsList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: kPrimaryColorLight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    drugsList[index].drugName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .fontSize! *
                                          0.85,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8.0),
                                  child: Text(
                                    'Dose: ${drugsList[index].dose}',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8.0),
                                  child: Text(
                                    'Start date: ${DateHelper.getFormattedStringFromISO(drugsList[index].startDate, kFormattedString)}',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8.0),
                                  child: Text(
                                    'End date: ${DateHelper.getFormattedStringFromISO(drugsList[index].endDate, kFormattedString)}',
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8.0),
                                  child: Text(
                                    'Currently taken: ${drugsList[index].currentlyTaken == true ? kYes : kNo}',
                                  ),
                                )
                              ],
                            ),
                            medication.doctorId ==
                                    BlocProvider.of<MedicationsListCubit>(
                                            context)
                                        .currentDoctorId
                                ? IconButton(
                                    icon: Icon(Icons.delete),
                                    color: kErrorColor,
                                    onPressed: () async {
                                      await DialogHelper.deleteDrugDialog(
                                        context,
                                        medication.id!,
                                        drugsList[index].drugId,
                                        index,
                                      );
                                    },
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
