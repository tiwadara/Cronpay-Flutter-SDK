import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedBorderDropdown extends StatefulWidget {
  RoundedBorderDropdown({this.data, this.onChange});

  final List<dynamic> data;
  final Function onChange;

  @override
  _RoundedBorderDropdownState createState() => _RoundedBorderDropdownState();
}

class _RoundedBorderDropdownState extends State<RoundedBorderDropdown> {
  final List<String> _dropdownValues = [
    "Switch Account",
    "Two",
    "Three",
    "Four",
    "Five"
  ];
  String _selected;
  List<dynamic> data = new List<dynamic>();

  @override
  void initState() {
    data = widget.data;
    _selected = widget.data.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: AppColors.shadow,
                blurRadius: 15.0,
                offset: Offset(0, 8)),
          ]),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: Icon(
            // Add this
            Icons.keyboard_arrow_down, // Add this
            color: AppColors.borderGrey,
            size: 25, // Add this
          ),
          items:  data == null
              ? _dropdownValues
                  .map((value) => DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            value,
                            style: TextStyle(
                                color: AppColors.borderGrey, fontSize: 15),
                          ),
                        ),
                        value: value,
                      ))
                  .toList()
              :  data
                  .map((value) => DropdownMenuItem(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            value,
                            style: TextStyle(
                                color: AppColors.borderGrey, fontSize: 15),
                          ),
                        ),
                        value: value,
                      ))
                  .toList(),
          onChanged: (value) {
            setState(() {
              _selected = value;
            });
             widget.onChange(value);
          },
          isExpanded: false,
          value: _selected,
        ),
      ),
    );
  }
}
