import 'package:final_pro/constants.dart';
import 'package:final_pro/cubits/teams_cubit/teams_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DropDownAppBar extends StatefulWidget {
  const DropDownAppBar({Key? key}) : super(key: key);

  @override
  _DropDownAppBarState createState() => _DropDownAppBarState();
}

class _DropDownAppBarState extends State<DropDownAppBar> {
  String selectedValue = dropDownValues[0];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        role == "patient"
            ? Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    menuMaxHeight: 4 * 50,
                    dropdownColor: Theme.of(context).primaryColor,
                    value: selectedValue, //followers
                    icon: Icon(
                      Icons.arrow_drop_down,
                      // color: themeContext.colorScheme.onBackground,
                    ),
                    elevation: 8,
                    onChanged: (newValue) async {
                      setState(() {
                        selectedValue = newValue!;
                      });
                      if (selectedValue == dropDownValues[0]) {
                        BlocProvider.of<TeamsCubit>(context).selectFollowers();
                      } else {
                        BlocProvider.of<TeamsCubit>(context).selectFollowings();
                      }
                    },
                    items: dropDownValues.map<DropdownMenuItem<String>>(
                      (dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              )
            : Text(kFollowings),
        // Container(
        //   color: Colors.red,
        //   width: 30,
        //   height: 20,
        // ),
        SizedBox(
          width: 100,
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        )
      ],
    );
  }
}
