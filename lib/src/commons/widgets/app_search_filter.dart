import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/widgets/app_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({Key key, this.hint, this.focusNode, this.onResultUpdated, this.onClicked})
      : super(key: key);

  final String hint;
  final Function onResultUpdated;
  final Function onClicked;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return Center(
      child: Material(
        child: AppTextInput(
          focusNode: focusNode,
            onTap: onClicked,
            keyboardType: TextInputType.text,
            icon: Boxicons.bx_search,
            labelText: hint ?? "Search",
            onChanged: (String searchQuery) => onResultUpdated(searchQuery)),
      ),
    );
  }
}
