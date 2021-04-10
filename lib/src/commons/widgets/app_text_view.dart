import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextInput extends StatelessWidget {
  final Function onChanged;
  final Function onTap;
  final String hintText;
  final IconData icon;
  final String labelText;
  final String textAsIcon;
  final FocusNode focusNode;
  final bool enabled;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final onSaved;
  final List<TextInputFormatter> inputFormatter;

  const AppTextInput(
      {Key key,
      this.onChanged,
      this.icon,
      this.labelText,
      this.hintText,
      this.textAsIcon,
      this.focusNode,
      this.onTap,
      this.keyboardType,
      this.enabled,
      this.inputFormatter,
      this.onSaved,
      this.validator,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                color: AppColors.shadow,
                blurRadius: 15.0,
                offset: Offset(0, 8)),
          ]),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                icon == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SizedBox(
                          width: 40,
                          child: Icon(
                            icon,
                            color: AppColors.borderGrey,
                          ),
                        )),
                textAsIcon == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: SizedBox(
                            width: 40,
                            child: Center(
                              child: Text(
                                textAsIcon,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.borderGrey),
                              ),
                            )),
                      ),
                icon == null && textAsIcon == null
                    ? Container()
                    : Container(
                        height: 20,
                        child: VerticalDivider(color: AppColors.borderGrey)),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 55.h,
                    child: Center(
                      child: TextFormField(
                          onSaved: onSaved,
                          inputFormatters: inputFormatter,
                          controller: controller,
                          focusNode: focusNode,
                          enabled: enabled,
                          onTap: onTap,
                          validator: validator,
                          onChanged: onChanged,
                          style: TextStyle(fontSize: 15),
                          keyboardType: keyboardType,
                          decoration: InputDecoration(
                              hintText: hintText,
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                  color:
                                      AppColors.accentDark.withOpacity(0.56)),
                              labelText: labelText)),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
