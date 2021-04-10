import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/beneficiaries/blocs/beneficiary/beneficiary_bloc.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/commons/util/bottom_sheet.dart';
import 'package:cron_pay/src/commons/util/strings.dart';
import 'package:cron_pay/src/commons/widgets/app_horizontal_line.dart';
import 'package:cron_pay/src/profile/blocs/dashboard/dashboard_bloc.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:cron_pay/src/profile/widgets/logout_bottom_sheet.dart';
import 'package:cron_pay/src/profile/widgets/profile_pix.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  static const String routeName = '/home';
  Profile();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final attributeValueTextController = TextEditingController();
  ProfileBloc _profileBloc;
  BeneficiaryBloc _beneficiaryBloc;
  DashboardBloc _dashboardBloc;
  User _user;
  int eventCount = 0;
  int beneficiaryCount = 0;

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _beneficiaryBloc = BlocProvider.of<BeneficiaryBloc>(context);
    _dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    _profileBloc.add(GetUserProfile());
    _beneficiaryBloc.add(GetBeneficiaries());
    _dashboardBloc.add(GetEventCount());
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
          children: [
            Stack(
              // overflow: Overflow.visible,
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                  child: Container(
                    height: 157.h,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.accentDark,
                              AppColors.primaryDark
                            ])),
                  ),
                ),
                Positioned(
                  top: 48.h,
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                    if (state is UserProfileReceived) {
                      _user = state.user;
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: 16.w,
                        ),
                        InkWell(
                          onTap: () {},
                          child: ProfilePicture(),
                        ),
                        SizedBox(
                          width: 12.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${camelize(_user?.firstName ?? "")}' +
                                  '${_user?.lastName ?? ""}',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text('${_user?.email ?? ""}',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
                Positioned(
                  top: 130.h,
                  child: Container(
                    height: 72.h,
                    width: 350.w,
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 16.0,
                          spreadRadius: 3.0,
                          offset: Offset(
                            0.0,
                            12.0,
                          ),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Scheduled Events",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mainBlack),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            BlocBuilder<DashboardBloc, DashboardState>(
                                builder: (context, state) {
                              if (state is DashboardCountReceived) {
                                eventCount = state.count;
                              }
                              return Text(
                                "$eventCount",
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.mainBlack),
                              );
                            }),
                          ],
                        ),
                        Container(
                            height: 40,
                            child: VerticalDivider(color: AppColors.grey)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Beneficiaries",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.mainBlack),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            BlocBuilder<BeneficiaryBloc, BeneficiaryState>(
                                builder: (context, state) {
                              if (state is BeneficiariesReturned) {
                                beneficiaryCount = state.beneficiaries.length;
                              }
                              return SizedBox(
                                width: 20,
                                child: Text(
                                  "$beneficiaryCount",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14, color: AppColors.mainBlack),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 55.h,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading:
                        Icon(FeatherIcons.user, color: AppColors.mainBlack),
                    title: Text(
                      'My Profile',
                      style:
                          TextStyle(fontSize: 13, color: AppColors.mainBlack),
                    ),
                    trailing: Icon(
                      FeatherIcons.chevronRight,
                      size: 20,
                      color: AppColors.grey,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.editProfile);
                    },
                  ),
                  AppHorizontalLine(),
                  ListTile(
                    leading:
                        Icon(Boxicons.bx_history, color: AppColors.mainBlack),
                    title: Text(
                      'Transaction History',
                      style:
                          TextStyle(fontSize: 13, color: AppColors.mainBlack),
                    ),
                    trailing: Icon(
                      FeatherIcons.chevronRight,
                      size: 20,
                      color: AppColors.grey,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.transactions);
                    },
                  ),
                  AppHorizontalLine(),
                  ListTile(
                    leading:
                        Icon(Boxicons.bx_group, color: AppColors.mainBlack),
                    title: Text(
                      'Beneficiaries',
                      style:
                          TextStyle(fontSize: 13, color: AppColors.mainBlack),
                    ),
                    trailing: Icon(
                      FeatherIcons.chevronRight,
                      size: 20,
                      color: AppColors.grey,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.beneficiaries);
                    },
                  ),
                  // AppHorizontalLine(),
                  // ListTile(
                  //   leading:
                  //       Icon(FeatherIcons.lock, color: AppColors.mainBlack),
                  //   title: Text(
                  //     'Change Password',
                  //     style:
                  //         TextStyle(fontSize: 13, color: AppColors.mainBlack),
                  //   ),
                  //   trailing: Icon(
                  //     FeatherIcons.chevronRight,
                  //     size: 20,
                  //     color: AppColors.grey,
                  //   ),
                  //   onTap: () {
                  //     Navigator.pushNamed(context, Routes.changePassword, arguments: User());
                  //   },
                  // ),
                  AppHorizontalLine(),
                  ListTile(
                    leading: Icon(
                      FeatherIcons.creditCard,
                      color: AppColors.mainBlack,
                    ),
                    title: Text(
                      'Payments Methods',
                      style:
                          TextStyle(fontSize: 13, color: AppColors.mainBlack),
                    ),
                    trailing: Icon(
                      FeatherIcons.chevronRight,
                      size: 20,
                      color: AppColors.grey,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, Routes.paymentMethods);
                    },
                  ),
                  AppHorizontalLine(),
                  ListTile(
                    leading:
                        Icon(FeatherIcons.power, color: AppColors.mainBlack),
                    title: Text(
                      'Sign Out',
                      style:
                          TextStyle(fontSize: 13, color: AppColors.mainBlack),
                    ),
                    trailing: Icon(
                      FeatherIcons.chevronRight,
                      size: 20,
                      color: AppColors.grey,
                    ),
                    onTap: () {
                      displayBottomSheet(context, LogoutWidget());
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
