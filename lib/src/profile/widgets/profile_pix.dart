import 'package:cached_network_image/cached_network_image.dart';
import 'package:cron_pay/src/auth/models/user.dart';
import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/app_constants.dart';
import 'package:cron_pay/src/profile/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {

  User user = User();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(AppConstants.screenWidth, AppConstants.screenHeight),
        allowFontScaling: false);
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is UserProfileReceived) {
          user = state.user;
          return Container(
            width: 65.0.w,
            height: 65.0.w,
            decoration:  user?.photoUrl == null ? BoxDecoration(
              color: AppColors.accentLighter,
              borderRadius: new BorderRadius.all(
                  new Radius.circular(50.0)),
              border: new Border.all(
                color: AppColors.white,
                width: 1.0,
              ),
            ): BoxDecoration(
              image: new DecorationImage(
                image: CachedNetworkImageProvider(  user?.photoUrl ?? ""),
                fit: BoxFit.cover,
              ),
              borderRadius: new BorderRadius.all(
                  new Radius.circular(50.0)),
              border: new Border.all(
                color: AppColors.white,
                width: 1.0,
              ),
            ),
            child: user.photoUrl == null ? Center(child: Text(user.firstName.characters.first.toUpperCase() + user.lastName.characters.first .toUpperCase() ,style: TextStyle(fontSize: 20,color:  AppColors.white),)) : Container(),
          );
        }
       return Container(
         width: 65.0.w,
         height: 65.0.w,
           decoration: BoxDecoration(
             color: AppColors.accentLighter,
             borderRadius: new BorderRadius.all(
                 new Radius.circular(50.0)),
             border: new Border.all(
               color: AppColors.white,
               width: 1.0,
             ),
           )
       );
      }
    );
  }
}