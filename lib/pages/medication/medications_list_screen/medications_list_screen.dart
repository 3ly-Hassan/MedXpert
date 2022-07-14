import 'package:final_pro/components/center_progress_indicator.dart';
import 'package:final_pro/components/error_bloc.dart';
import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/medication_cubits/drugs_list_cubit/drugs_list_cubit.dart';
import 'package:final_pro/dialog_helper.dart';
import 'package:final_pro/pages/medication/drugs_list_screen/drugs_list_screen.dart';
import 'package:final_pro/pages/teams/main/components/no_followers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubits/medication_cubits/medications_list_cubit/medications_list_cubit.dart';
import '../shared_componenets/create_medication_floating_button.dart';

//TODO: MAY BE WE NEED TO ADD ANIMATION IN VIEWING LIST IN ALL SCREENS LIKE WHAT WAS IN TEAMS

class MedicationsListScreen extends StatefulWidget {
  static String routeName = "/medications_list";

  const MedicationsListScreen({Key? key}) : super(key: key);

  @override
  State<MedicationsListScreen> createState() => _MedicationsListScreenState();
}

class _MedicationsListScreenState extends State<MedicationsListScreen> {
  @override
  void initState() {
    BlocProvider.of<MedicationsListCubit>(context).getMedicationsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Medications list'),
        backgroundColor: kAppBarColor,
      ),
      floatingActionButton:
          role == 'patient' ? createMedicationFloatingButton(context) : null,
      body: BlocConsumer<MedicationsListCubit, MedicationsListState>(
        listener: (context, state) {
          if (state is DeleteFailedState) {
            showToast(text: 'Deleting failed', state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          if (state is MedicationsListLoadingState) {
            return CenterProgressIndicator();
          }
          //
          else if (state is GetMedicationsListState ||
              state is DeleteFailedState) {
            List medicationList = [];
            //
            if (state is GetMedicationsListState) {
              medicationList = state.medicationsList;
            } else if (state is DeleteFailedState) {
              medicationList = state.medicationsList;
            }
            //
            return medicationList.isEmpty
                ? NoFollowersWidget(msg: 'No medications yet')
                : ListView.builder(
                    itemCount: medicationList.length,
                    itemBuilder: (context, index) {
                      print(medicationList[index].doctorId);
                      return Padding(
                        padding:
                            EdgeInsets.fromLTRB(8, index == 0 ? 10 : 0, 8, 10),
                        child: ListTile(
                          title: medicationList[index].doctorName == null
                              ? Text(medicationList[index].name)
                              : Text(
                                  '${medicationList[index].name} (Made by ${medicationList[index].doctorName})'),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...medicationList[index].drugs.map(
                                  (element) {
                                    return Text("• ${element.drugName!}");
                                  },
                                ).toList(),
                              ],
                            ),
                          ),
                          trailing: checkAuthorizationInMedicationsListScreen(
                                  context, medicationList[index])
                              ? IconButton(
                                  icon: Icon(Icons.delete),
                                  color: kErrorColor,
                                  onPressed: () async {
                                    DialogHelper.deleteMedicationDialog(
                                        context,
                                        medicationList[index].id,
                                        medicationList[index].drugs,
                                        index);
                                  },
                                )
                              : null,
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              DrugsListScreen.routeName,
                              arguments: medicationList[index],
                            );
                            BlocProvider.of<DrugsListCubit>(context)
                                .getDrugsList(medicationList[index]);
                          },
                        ),
                      );
                    },
                  );

            // : SingleChildScrollView(
            //     child: Column(
            //         children: List.generate(medicationList.length, (index) {
            //       return Theme(
            //         data: Theme.of(context).copyWith(
            //           cardColor: Theme.of(context).primaryColorLight,
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: 16.0, vertical: 8.0),
            //           child: ClipRRect(
            //             borderRadius: BorderRadius.circular(25),
            //             child: ExpansionPanelList(
            //                 expandedHeaderPadding:
            //                     const EdgeInsets.symmetric(
            //                   vertical: 8.0,
            //                   horizontal: 16,
            //                 ),
            //                 expansionCallback: (int _, bool value) {
            //                   setState(() {
            //                     expandingValues[index] = !value;
            //                   });
            //                 },
            //                 children: [
            //                   ExpansionPanel(
            //                     canTapOnHeader: true,
            //                     isExpanded: expandingValues[index],
            //                     headerBuilder: (context, _) {
            //                       return Padding(
            //                         padding: const EdgeInsets.all(16.0),
            //                         child: Text(medicationList[index].name),
            //                       );
            //                     },
            //                     body: Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: Row(
            //                         mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Column(
            //                             children: [
            //                               ...medicationList[index]
            //                                   .drugs
            //                                   .map(
            //                                     (element) => Text(
            //                                         "• ${element.drugName!}"),
            //                                   )
            //                                   .toList(),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   )
            //                 ]
            //
            //                 // children: [
            //                 //   ExpansionPanel(
            //                 //     isExpanded: isExpanded,
            //                 //     headerBuilder: (context, _) {
            //                 //       return Padding(
            //                 //         padding: const EdgeInsets.all(8.0),
            //                 //         child: Text('congestal'),
            //                 //       );
            //                 //     },
            //                 //     body: isExpanded
            //                 //         ? SingleChildScrollView(
            //                 //             child: Column(
            //                 //               children: [],
            //                 //             ),
            //                 //           )
            //                 //         : Container(),
            //                 //   ),
            //                 // ],
            //
            //                 ),
            //           ),
            //         ),
            //       );
            //     })),
            //   );
          }
          return ErrorBloc();
        },
      ),
    );
  }
}
