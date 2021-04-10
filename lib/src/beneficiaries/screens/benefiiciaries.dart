import 'package:cron_pay/src/beneficiaries/blocs/beneficiary/beneficiary_bloc.dart';
import 'package:cron_pay/src/beneficiaries/models/beneficiary.dart';
import 'package:cron_pay/src/beneficiaries/widgets/beneficiary_list.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/widgets/app_header.dart';
import 'package:cron_pay/src/commons/widgets/app_search_filter.dart';
import 'package:cron_pay/src/commons/widgets/app_widget_transition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Beneficiaries extends StatefulWidget {
  static const String routeName = '/beneficiaries';
  Beneficiaries();

  @override
  _BeneficiariesState createState() => _BeneficiariesState();
}

class _BeneficiariesState extends State<Beneficiaries> {
  final attributeValueTextController = TextEditingController();
  BeneficiaryBloc _beneficiaryBloc;
  List<Beneficiary> _beneficiaries = [];
  List<Beneficiary> filterResult;

  @override
  void initState() {
    _beneficiaryBloc = BlocProvider.of<BeneficiaryBloc>(context);
    _beneficiaryBloc.add(GetBeneficiaries());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
        backgroundColor: AppColors.windowColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Header(
                previous: Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      FeatherIcons.x,
                      color: AppColors.white,
                    ),
                  ),
                ),
                title: "Beneficiaries"),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Hero(
                        tag: "search",
                        child: SearchFilter(
                          hint: "Search by name, account or Alias",
                          onClicked: () {},
                          onResultUpdated: (String query) {
                            print("querry" + query.toString());
                            // if (query.isEmpty || query == "") {
                            //   filterResult = _beneficiaries;
                            //   _beneficiaryBloc.add(FilterEvent(filterResult));
                            // } else {
                            filterResult = _beneficiaries.where((element) {
                              return (element.alias ?? "".toLowerCase().contains(query.toLowerCase())) ||
                                  (element.accountNumber.toLowerCase().contains(query.toLowerCase())) ||
                                  (element.bank.name.toLowerCase().contains(query.toLowerCase()));
                            }).toList();
                            _beneficiaryBloc.add(FilterEvent(filterResult));
                            // }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      BlocBuilder<BeneficiaryBloc, BeneficiaryState>(
                        buildWhen: (previous, current) => current is BeneficiariesReturned || current is GettingBeneficiaries || current is FilteredState ,
                          builder: (context, state) {
                            if (state is BeneficiariesReturned) {
                              _beneficiaries = state.beneficiaries.reversed.toList();
                              if (_beneficiaries.isEmpty) {
                                return buildEmptyBeneficiaryContainer(context);
                              } else {
                                return ShowUp(
                                    delay: 500,
                                    child: BeneficiaryList(
                                        beneficiaries: _beneficiaries));
                              }
                            } else if (state is GettingBeneficiaries) {
                              return CircularProgressIndicator();
                            } else if (state is FilteredState) {
                              print("dfrdfdf" + state.filterResult.toString());
                              filterResult = state.filterResult.reversed.toList();

                              return ShowUp(
                                  delay: 500,
                                  child: BeneficiaryList(
                                      beneficiaries: filterResult));
                            }
                            return Container();
                          }),
                      SizedBox(
                        height: 30.h,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Container buildEmptyBeneficiaryContainer(BuildContext context) {
    return Container(
      height: 200.h,
      child: Column(
        children: [
          // IconButton(
          //   icon: Icon(
          //     Boxicons.bxs_plus_circle,
          //     color: AppColors.primaryDark,
          //   ),
          //   onPressed: () {},
          // ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "You have no saved beneficiary",
            textAlign: TextAlign.center,
            style: TextStyle(),
          )),
        ],
      ),
    );
  }
}
