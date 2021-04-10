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

class Spinner extends StatefulWidget {
  final List<AppDropDown2Item> items;
  final Function(AppDropDown2Item down2item) onSelect;
  String hintText;
  AppDropDown2Item selected;
  final String helpText;



  Spinner({
    @required this.items,
    @required this.onSelect,
    this.hintText = "",
    @required this.selected,
    this.helpText = ""
  });

  @override
  _SpinnerState createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
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
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 15.0,
                    offset: Offset(0, 8)),
              ]),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<AppDropDown2Item>(
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
              style: TextStyle(color: AppColors.textColor, fontSize: 14),
              items: widget.items.map((AppDropDown2Item e){
                return DropdownMenuItem(
                  child: Container(
                    child: Text(
                      e.title,
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
              hint: Text(widget.hintText),
            ),
          ),
        ),
      ],
    );
  }
}
