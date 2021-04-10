import 'package:cron_pay/src/commons/constants/app_colors.dart';
import 'package:cron_pay/src/commons/constants/routes_constant.dart';
import 'package:cron_pay/src/splash/blocs/splash/bloc.dart';
import 'package:cron_pay/src/splash/blocs/splash/splash_bloc.dart';
import 'package:cron_pay/src/splash/models/walkthrough.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SlideProgressWidget extends StatefulWidget {
  const SlideProgressWidget(
      {Key key,
      @required this.swiperController,
      @required this.pages,
      @required this.indexCountOnSwipe})
      : super(key: key);

  final SwiperController swiperController;
  final List<WalkThrough> pages;
  final ValueNotifier indexCountOnSwipe;

  @override
  _SlideProgressWidgetState createState() => _SlideProgressWidgetState();
}

class _SlideProgressWidgetState extends State<SlideProgressWidget> {
  double slideProgress = 0.0;
  SplashBloc _splashBloc;

  @override
  void initState() {
    _splashBloc = BlocProvider.of<SplashBloc>(context);
    slideProgress = 1 / widget.pages.length;
    widget.indexCountOnSwipe.addListener(() {
      setState(() {
        slideProgress =  ( widget.indexCountOnSwipe.value + 1 )  / widget.pages.length ;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(
                strokeWidth: 1.5,
                backgroundColor: AppColors.windowColor,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
                value: slideProgress)),
        FloatingActionButton(
          onPressed: () {
            if (slideProgress == 1) {
              _splashBloc.add(OnboardingSeenEvent());
              return Navigator.pushNamedAndRemoveUntil(
                  context, Routes.home, (Route<dynamic> route) => false);
            } else {
              widget.swiperController.next();
              setState(() {
                slideProgress += 1 / widget.pages.length;
              });
            }
          },
          child: Icon(
            FeatherIcons.arrowRight,
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: AppColors.accentDark,
        ),
      ],
    );
  }
}
