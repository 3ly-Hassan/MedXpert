import 'package:final_pro/constants.dart';
import 'package:flutter/material.dart';

class DropDownAppBar extends StatefulWidget {
  const DropDownAppBar({Key? key}) : super(key: key);

  @override
  _DropDownAppBarState createState() => _DropDownAppBarState();
}

class _DropDownAppBarState extends State<DropDownAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            isExpanded: true,
            menuMaxHeight: 4 * 50,

            dropdownColor: Theme.of(context).primaryColor,
            // style: TextStyle(
            //   fontSize: FontHelper.headline6(context).fontSize,
            //   color: themeContext.colorScheme.onBackground,
            // ),
            value: dropDownValues[0], //followers
            icon: Icon(
              Icons.arrow_drop_down,
              // color: themeContext.colorScheme.onBackground,
            ),
            elevation: 8,
            onChanged: (newValue) async {
              //
              if (newValue == dropDownValues[0]) {
                //TODO show followers
              } else {
                //TODO show followings

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
