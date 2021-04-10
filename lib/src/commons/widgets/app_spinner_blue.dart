import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:equatable/equatable.dart';

class AppDropDown2Item extends Equatable {
  final dynamic code;
  final String title;
  final Map<String, dynamic> meta;

  AppDropDown2Item(this.code, this.title, {this.meta});
  @override
  List<Object> get props => [code, title, meta,];


}

class SpinnerBlue extends StatefulWidget {
  final List<AppDropDown2Item> items;
  final Function(AppDropDown2Item down2item) onSelect;
  String hintText;
  AppDropDown2Item selected;
  final String helpText;



  SpinnerBlue({
    @required this.items,
    @required this.onSelect,
    this.hintText = "",
    @required this.selected,
    this.helpText = ""
  });

  @override
  _SpinnerBlueState createState() => _SpinnerBlueState();
}

class _SpinnerBlueState extends State<SpinnerBlue> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 55.h,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              color: AppColors.accentLight,
              borderRadius: BorderRadius.circular(10.0)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AppDropDown2Item>(
              dropdownColor:AppColors.accentDark,
              onTap: () {
                FocusManager.instance.primaryFocus.unfocus();
              },
              icon: Icon(
                // Add this
                Icons.keyboard_arrow_down, // Add this
                color: AppColors.borderGrey,
                size: 25, // Add this
              ),
              value:  widget.selected,
              style: TextStyle(color: AppColors.white, fontSize: 14),
              items: widget.items.map((AppDropDown2Item e){
                return DropdownMenuItem(
                  child: Container(
                    child: Text(
                      e.title,style: TextStyle(color: AppColors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  value: e,
                );
              } ).toList(),
              onChanged: (value) {
                setState(() {
                  widget.selected = value;
                  widget.hintText = value.title;
                });
                widget.onSelect(value);
              },
              hint: Text(widget.hintText, style: TextStyle(color: AppColors.white),),
            ),
          ),
        ),
      ],
    );
  }
}
