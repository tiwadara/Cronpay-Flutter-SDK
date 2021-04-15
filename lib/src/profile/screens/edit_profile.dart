import 'dart:convert';
import 'dart:io';

import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/commons/util/strings.dart';
import 'package:cron_pay/src/commons/widgets/app_loader.dart';
import 'package:cron_pay/src/commons/widgets/app_snackbar.dart';
import 'package:cron_pay/src/commons/widgets/primary_button.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:cron_pay/src/profile/widgets/profile_pix.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = '/editProfile';
  EditProfile();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final attributeValueTextController = TextEditingController();
  ProfileBloc _profileBloc;
  User _currentUser = new User();
  User _user = new User();
  final _formKey = GlobalKey<FormState>();
  var isButtonDisabled = true;
  File _image;
  List<String> _base64Images = List<String>();

  @override
  void initState() {
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(GetUserProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.windowColor,
        body: BlocConsumer<ProfileBloc, ProfileState>(
            listenWhen: (previous, current) => current is UserProfileReceived,
            listener: (context, state) {
              if (state is UserProfileReceived) {
                _user = User(
                    firstName: state.user.firstName,
                    lastName: state.user.lastName);
              }
            },
            buildWhen: (previous, current) => current is UserProfileReceived,
            builder: (context, state) {
              if (state is UserProfileReceived) {
                _currentUser = state.user;
                return buildView();
              }
              return buildView();
            }));
  }

  Stack buildView() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: double.infinity,
          color: AppColors.windowColor,
        ),
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
                    colors: [AppColors.accentDark, AppColors.primaryDark])),
          ),
        ),
        Positioned(
          top: 48.h,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        pickFile();
                      },
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _image == null
                              ? ProfilePicture()
                              : Container(
                                  width: 65.0.w,
                                  height: 65.0.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.accentDark,
                                    image: new DecorationImage(
                                      image: FileImage(_image),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(50.0)),
                                    border: new Border.all(
                                      color: AppColors.white,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                          Positioned(
                            bottom: 0,
                            right: -10,
                            child: InkWell(
                              onTap: () {
                                pickFile();
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.accentDark,
                                ),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: AppColors.white,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: -10,
                            child: BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, state) {
                                if (state is UpdatingProfilePicture) {
                                  return Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text('Tell us more about you...',
                            style: TextStyle(
                                fontSize: 11,
                                color: AppColors.white,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    IconButton(
                      icon: Icon(FeatherIcons.x),
                      color: AppColors.white,
                      onPressed: () {
                        gotoNextScreen();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 130.h,
          left: 15,
          right: 15,
          child: Container(
            // height: 300.h,
            width: 350.w,
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
            child: Form(
              key: _formKey,
              child: Container(
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
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                FeatherIcons.user,
                                color: AppColors.grey,
                              )),
                          Expanded(
                              child: TextFormField(
                                  onChanged: (final String text) {
                                    _user.firstName = text;
                                    watchFormState();
                                  },
                                  initialValue:
                                      camelize(_currentUser?.firstName ?? ""),
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelStyle:
                                          TextStyle(color: AppColors.grey),
                                      labelText: 'FIRST NAME'))),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                FeatherIcons.user,
                                color: AppColors.grey,
                              )),
                          Expanded(
                              child: TextFormField(
                                  onChanged: (final String text) {
                                    _user.lastName = text;
                                    watchFormState();
                                  },
                                  initialValue:
                                      camelize(_currentUser?.lastName ?? ""),
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    labelText: 'LAST NAME',
                                    border: InputBorder.none,
                                    labelStyle:
                                        TextStyle(color: AppColors.grey),
                                  ))),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.mail_outline,
                                color: AppColors.grey,
                              )),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      onChanged: (final String text) {
                                        _user.email = text;
                                      },
                                      enabled: false,
                                      initialValue: _currentUser?.email,
                                      style: TextStyle(
                                          fontSize: 15, color: AppColors.grey),
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          labelStyle:
                                              TextStyle(color: AppColors.grey),
                                          labelText: 'EMAIL')),
                                ),
                                Icon(
                                  Boxicons.bxs_check_circle,
                                  color: AppColors.primary,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Icon(
                                Icons.phone_outlined,
                                color: AppColors.grey,
                              )),
                          Expanded(
                            child: TextFormField(
                                onChanged: (final String text) {
                                  _user.phone = text;
                                },
                                enabled: false,
                                initialValue:
                                    camelize(_currentUser?.phone ?? ""),
                                style: TextStyle(
                                    fontSize: 15, color: AppColors.grey),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelStyle:
                                        TextStyle(color: AppColors.grey),
                                    labelText: 'MOBILE NUMBER')),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 15,
          right: 15,
          child: PrimaryButton(
              label: 'SAVE',
              color: AppColors.primaryDark,
              onPressed: isButtonDisabled
                  ? null
                  : () {
                      updateUserDetails();
                    }),
        ),
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is UserProfileUpdated) {
              Navigator.pop(context);
              AppSnackBar().show(message: "Profile Updated");
              _profileBloc.add(GetUserProfile());
            } else if (state is ProfilePictureUpdated) {
              AppSnackBar().show(message: "Photo Updated");
              _profileBloc.add(GetUserProfile());
            }
          },
          child: Container(),
        )
      ],
    );
  }

  void watchFormState() {
    if (_user.firstName == null || _user.lastName == null) {
      setState(() => isButtonDisabled = true);
    } else {
      setState(() => isButtonDisabled = false);
    }
  }

  void gotoNextScreen() {
    Navigator.pop(context);
  }

  void updateUserDetails() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      showOverlay(context, "Updating Profile");
      _profileBloc.add(UpdateUserProfile(_user));
    } else {
      AppSnackBar().show(message: "Please, correct invalid fields");
    }
  }

  Future<void> pickFile() async {
    // FilePickerResult result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   File file = File(result.files.single.path);
    //   _cropImage(file);
    // }
  }
}
